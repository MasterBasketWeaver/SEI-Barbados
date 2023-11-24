codeunit 75004 "BA Subscibers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostGLAccICLine', '', false, false)]
    local procedure PurchPostOnBeforePostGLAccICLine(var PurchLine: Record "Purchase Line")
    var
        ServiceLine: Record "Service Line";
        GLAccount: Record "G/L Account";
    begin
        if (PurchLine."Document Type" in [PurchLine."Document Type"::Invoice, PurchLine."Document Type"::"Credit Memo"])
                and GLAccount.Get(PurchLine."No.") and GLAccount."BA Require Commission No." and (PurchLine."BA Commission Invoice No." = '') then
            Error(NoCommissionErr, GLAccount.TableCaption, GLAccount."No.", PurchLine."Line No.", PurchLine.FieldCaption("BA Commission Invoice No."));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', false, false)]
    local procedure PurchPostOnBeforePurchInvLineInsert(var PurchaseLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")
    begin
        PurchInvLine."BA Commission Invoice No." := PurchaseLine."BA Commission Invoice No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoLineInsert', '', false, false)]
    local procedure PurchPostOnBeforePurchCrMemoLineInsert(var PurchLine: Record "Purchase Line"; var PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    begin
        PurchCrMemoLine."BA Commission Invoice No." := PurchLine."BA Commission Invoice No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure SalesPostOnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header")
    begin
        SalesInvHeader."BA Order No." := SalesInvHeader."Order No.";
        SalesInvHeader."BA Posting Date" := SalesInvHeader."Posting Date";
        SalesInvHeader."BA Sell-to Customer Name" := SalesInvHeader."Sell-to Customer Name";
        SalesInvHeader."BA Sell-to Customer No." := SalesInvHeader."Sell-to Customer No.";
        SalesInvHeader."BA Ship-to Name" := SalesInvHeader."Ship-to Name";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', false, false)]
    local procedure SalesHeaderOnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Quote:
                begin
                    SalesHeader.SetHideValidationDialog(true);
                    SalesHeader.Validate("Order Date", 0D);
                    SalesHeader.Validate("BA Quote Date", Today());
                    SalesHeader.Validate("Shipment Date", 0D);
                end;
            SalesHeader."Document Type"::Order:
                SalesHeader.Validate("Shipment Date", 0D);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterOnRun', '', false, false)]
    local procedure SalesQuoteToOrderOnAfterOnRun(var SalesOrderHeader: Record "Sales Header")
    begin
        SalesOrderHeader.SetHideValidationDialog(true);
        SalesOrderHeader.Validate("Document Date", Today());
        SalesOrderHeader.Validate("Order Date", Today());
        SalesOrderHeader.Validate("Shipment Date", 0D);
        SalesOrderHeader.Modify(true);
    end;

    var
        NoCommissionErr: Label '%1 %2 on line %3 requires a %4.';
}