codeunit 75003 "BA Dimension Mgt."
{
    Permissions = tabledata "Sales Invoice Line" = m,
    tabledata "Item Ledger Entry" = m,
    tabledata "Value Entry" = m,
    tabledata "G/L Entry" = im;



    var
        MultiUpdateSingleMsg: Label 'Line %1 also has the same dimensions as line %2, do you want to update both lines together?';
        MultiUpdatePluralMsg: Label 'Lines %1 also have the same dimensions as line %2, do you want to update all the lines together?';
        SplitDimMsg: Label '%1 is part of a merged G/L Entry, do you want to split the G/L Entry to update the related dimensions?';
        CancelledMsg: Label 'Cancelled.';
        EditDimMsg: Label 'Edit Dimensions';



    procedure EditSalesInvoiceLineDimensions(var SalesInvLine: Record "Sales Invoice Line")
    var
        GeneralPostingSet: Record "General Posting Setup";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        GLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        TempGLEntry: Record "G/L Entry" temporary;
        DimSetEntry: Record "Dimension Set Entry" temporary;
        SalesInvLine2: Record "Sales Invoice Line";
        TempSalesInvLine: Record "Sales Invoice Line" temporary;
        DimMgt: Codeunit DimensionManagement;
        NewDimSet: Integer;
        i: Integer;
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];

        LineNos: TextBuilder;
        MultiUpdate: Boolean;
    begin
        GLSetup.Get();
        GLSetup.TestField("Global Dimension 1 Code");
        GLSetup.TestField("Global Dimension 2 Code");

        NewDimSet := DimMgt.EditDimensionSet(SalesInvLine."Dimension Set ID", EditDimMsg);
        if NewDimSet = SalesInvLine."Dimension Set ID" then
            exit;

        DimMgt.GetDimensionSet(DimSetEntry, NewDimSet);
        DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
        if DimSetEntry.FindFirst() then
            GlobalDim1 := DimSetEntry."Dimension Value Code";
        DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
        if DimSetEntry.FindFirst() then
            GlobalDim2 := DimSetEntry."Dimension Value Code";

        ItemLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Document Line No.");
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Invoice");
        ItemLedgerEntry.SetRange("Document No.", SalesInvLine."Document No.");
        ItemLedgerEntry.SetRange("Document Line No.", SalesInvLine."Line No.");
        if ItemLedgerEntry.FindSet(true) then
            repeat
                ItemLedgerEntry."Global Dimension 1 Code" := GlobalDim1;
                ItemLedgerEntry."Global Dimension 2 Code" := GlobalDim2;
                ItemLedgerEntry."Dimension Set ID" := NewDimSet;
                ItemLedgerEntry.Modify(true);
            until ItemLedgerEntry.Next() = 0;


        ValueEntry.SetCurrentKey("Document No.", "Document Type", "Document Line No.");
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetRange("Document No.", SalesInvLine."Document No.");
        ValueEntry.SetRange("Document Line No.", SalesInvLine."Line No.");
        if ValueEntry.FindSet(true) then
            repeat
                ValueEntry."Global Dimension 1 Code" := GlobalDim1;
                ValueEntry."Global Dimension 2 Code" := GlobalDim2;
                ValueEntry."Dimension Set ID" := NewDimSet;
                ValueEntry.Modify(true);
            until ValueEntry.Next() = 0;

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
                                MultiUpdate := false;
                                SalesInvLine2.SetRange("Document No.", SalesInvLine."Document No.");
                                SalesInvLine2.SetFilter("Line No.", '<>%1', SalesInvLine."Line No.");
                                SalesInvLine2.SetRange("Dimension Set ID", SalesInvLine."Dimension Set ID");
                                if SalesInvLine2.FindSet() then begin
                                    repeat
                                        if LineNos.Length() = 0 then
                                            LineNos.Append(Format(SalesInvLine2."Line No."))
                                        else
                                            LineNos.Append(StrSubstNo(', %1', SalesInvLine2."Line No."));
                                        TempSalesInvLine := SalesInvLine2;
                                        TempSalesInvLine.Insert(false);
                                    until SalesInvLine2.Next() = 0;
                                    if TempSalesInvLine.Count() = 1 then
                                        MultiUpdate := Confirm(StrSubstNo(MultiUpdateSingleMsg, LineNos.ToText(), SalesInvLine."Line No."))
                                    else
                                        MultiUpdate := Confirm(StrSubstNo(MultiUpdatePluralMsg, LineNos.ToText(), SalesInvLine."Line No."));
                                end;
                                if not MultiUpdate and (GLEntry.Amount <> -SalesInvLine.Amount) then begin
                                    if not Confirm(StrSubstNo(SplitDimMsg, SalesInvLine.RecordId)) then
                                        Error(CancelledMsg);
                                    SplitGLEntry(GLEntry, -SalesInvLine.Amount, NewDimSet, GlobalDim1, GlobalDim2);
                                end else
                                    if not TempGLEntry.Get(GLEntry."Entry No.") then begin
                                        TempGLEntry := GLEntry;
                                        TempGLEntry.Insert(false);
                                    end;
                                break;
                            end;
                        until GeneralPostingSet.Next() = 0;
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
                end;
        end;

        if TempGLEntry.FindSet() then
            repeat
                GLEntry.Get(TempGLEntry."Entry No.");
                GLEntry."Global Dimension 1 Code" := GlobalDim1;
                GLEntry."Global Dimension 2 Code" := GlobalDim2;
                GLEntry."Dimension Set ID" := NewDimSet;
                GLEntry.Modify(true);
            until TempGLEntry.Next() = 0;

        SalesInvLine.Validate("Dimension Set ID", NewDimSet);
        SalesInvLine.Validate("Shortcut Dimension 1 Code", GlobalDim1);
        SalesInvLine.Validate("Shortcut Dimension 2 Code", GlobalDim2);
        SalesInvLine.Modify(true);

        if MultiUpdate and TempSalesInvLine.FindSet() then
            repeat
                SalesInvLine.Get(TempSalesInvLine.RecordId());
                SalesInvLine.Validate("Dimension Set ID", NewDimSet);
                SalesInvLine.Validate("Shortcut Dimension 1 Code", GlobalDim1);
                SalesInvLine.Validate("Shortcut Dimension 2 Code", GlobalDim2);
                SalesInvLine.Modify(true);
            until TempSalesInvLine.Next() = 0;
    end;

    local procedure SplitGLEntry(var GLEntry: Record "G/L Entry"; Amount: Decimal; NewDimID: Integer; GlobalDim1: Code[20]; GlobalDim2: Code[20])
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
        NewGLEntry."Global Dimension 1 Code" := GlobalDim1;
        NewGLEntry."Global Dimension 2 Code" := GlobalDim2;
        NewGLEntry."Dimension Set ID" := NewDimID;
        NewGLEntry.Insert(true);

        GLEntry.Amount -= Amount;
        GLEntry."Credit Amount" := -GLEntry.Amount;
        GLEntry.Modify(true);
    end;
}