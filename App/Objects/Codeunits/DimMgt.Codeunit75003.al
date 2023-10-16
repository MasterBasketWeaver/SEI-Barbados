codeunit 75003 "BA Dimension Mgt."
{
    Permissions = tabledata "Sales Invoice Line" = m,
    tabledata "Item Ledger Entry" = m,
    tabledata "Value Entry" = m,
    tabledata "G/L Entry" = im;


    procedure EditSalesInvoiceLineDimensions(var SalesInvLine: Record "Sales Invoice Line")
    var
        GeneralPostingSet: Record "General Posting Setup";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        GLEntry: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        NewDimSet: Integer;
    begin
        NewDimSet := DimMgt.EditDimensionSet(SalesInvLine."Dimension Set ID", 'Edit Dimensions');
        if NewDimSet = SalesInvLine."Dimension Set ID" then
            exit;

        ItemLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Document Line No.");
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Invoice");
        ItemLedgerEntry.SetRange("Document No.", SalesInvLine."Document No.");
        ItemLedgerEntry.SetRange("Document Line No.", SalesInvLine."Line No.");
        ItemLedgerEntry.ModifyAll("Dimension Set ID", NewDimSet, true);

        ValueEntry.SetCurrentKey("Document No.", "Document Type", "Document Line No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange("Document No.", SalesInvLine."Document No.");
        ValueEntry.SetRange("Document Line No.", SalesInvLine."Line No.");
        ValueEntry.ModifyAll("Dimension Set ID", NewDimSet, true);

        case SalesInvLine.Type of
            SalesInvLine.Type::Item:
                begin
                    GeneralPostingSet.SetFilter("Sales Account", '<>%1', '');
                    if GeneralPostingSet.FindSet() then begin
                        GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                        GLEntry.SetRange("Document No.", SalesInvLine."Document No.");
                        GLEntry.SetRange("Gen. Posting Type", GLEntry."Gen. Posting Type"::Sale);
                        GLEntry.SetRange("Dimension Set ID", SalesInvLine."Dimension Set ID");
                        repeat
                            GLEntry.SetRange("G/L Account No.", GeneralPostingSet."Sales Account");
                            if GLEntry.FindFirst() then begin
                                if GLEntry.Amount <> -SalesInvLine.Amount then begin
                                    if not Confirm(StrSubstNo('%1 is part of a merged G/L Entry, do you want to split the G/L Entry to update the related dimensions?', SalesInvLine.RecordId)) then
                                        Error('Cancelled.');
                                    SplitGLEntry(GLEntry, -SalesInvLine.Amount, NewDimSet);
                                end else
                                    if not TempGLEntry.Get(GLEntry."Entry No.") then begin
                                        TempGLEntry := GLEntry;
                                        TempGLEntry.Insert(false);
                                    end;
                                break;
                            end;
                        until GeneralPostingSet.Next() = 0;
                        if TempGLEntry.FindSet() then
                            repeat
                                GLEntry.Get(TempGLEntry."Entry No.");
                                GLEntry."Dimension Set ID" := NewDimSet;
                                GLEntry.Modify(true);
                            until TempGLEntry.Next() = 0;
                    end;
                end;
            SalesInvLine.Type::"G/L Account":
                begin
                    GLEntry.SetRange("Document Type", GLEntry."Document Type"::Invoice);
                    GLEntry.SetRange("Document No.", SalesInvLine."Document No.");
                    GLEntry.SetRange("G/L Account No.", SalesInvLine."No.");
                    GLEntry.SetRange(Amount, -SalesInvLine.Amount);
                    GLEntry.SetRange("Dimension Set ID", SalesInvLine."Dimension Set ID");
                    if GLEntry.FindSet() then
                        repeat
                            TempGLEntry := GLEntry;
                            TempGLEntry.Insert(false);
                        until GLEntry.Next() = 0;
                    if TempGLEntry.FindSet() then
                        repeat
                            GLEntry.Get(TempGLEntry."Entry No.");
                            GLEntry."Dimension Set ID" := NewDimSet;
                            GLEntry.Modify(true);
                        until TempGLEntry.Next() = 0;
                end;
        end;

        if not Confirm(StrSubstNo('%1 -> %2', SalesInvLine."Dimension Set ID", NewDimSet)) then
            Error('');

        SalesInvLine.Validate("Dimension Set ID", NewDimSet);
        SalesInvLine.Modify(true);
    end;

    local procedure SplitGLEntry(var GLEntry: Record "G/L Entry"; Amount: Integer; NewDimID: Integer)
    var
        NewGLEntry: Record "G/L Entry";
        EntryNo: Integer;
    begin
        if NewGLEntry.FindLast() then
            EntryNo := NewGLEntry."Entry No.";
        NewGLEntry := GLEntry;
        NewGLEntry."Entry No." := EntryNo + 1;
        NewGLEntry.Amount := Amount;
        NewGLEntry."Credit Amount" := -Amount;
        NewGLEntry."Dimension Set ID" := NewDimID;
        NewGLEntry.Insert(true);

        GLEntry.Amount -= Amount;
        GLEntry."Credit Amount" := -GLEntry.Amount;
        GLEntry.Modify(true);
    end;
}