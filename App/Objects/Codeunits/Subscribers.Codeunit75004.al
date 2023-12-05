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
    local procedure SalesPostOnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        SalesInvHeader."BA Order No." := SalesInvHeader."Order No.";
        SalesInvHeader."BA Posting Date" := SalesInvHeader."Posting Date";
        SalesInvHeader."BA Sell-to Customer Name" := SalesInvHeader."Sell-to Customer Name";
        SalesInvHeader."BA Sell-to Customer No." := SalesInvHeader."Sell-to Customer No.";
        SalesInvHeader."BA Ship-to Name" := SalesInvHeader."Ship-to Name";
        SalesHeader.CalcFields("BA Bill-to County Fullname", "BA Sell-to County Fullname", "BA Ship-to County Fullname");
        SalesInvHeader."BA Bill-to County Fullname" := SalesHeader."BA Bill-to County Fullname";
        SalesInvHeader."BA Sell-to County Fullname" := SalesHeader."BA Sell-to County Fullname";
        SalesInvHeader."BA Ship-to County Fullname" := SalesHeader."BA Ship-to County Fullname";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure SalesPostOnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("BA Bill-to County Fullname", "BA Sell-to County Fullname", "BA Ship-to County Fullname");
        SalesShptHeader."BA Bill-to County Fullname" := SalesHeader."BA Bill-to County Fullname";
        SalesShptHeader."BA Sell-to County Fullname" := SalesHeader."BA Sell-to County Fullname";
        SalesShptHeader."BA Ship-to County Fullname" := SalesHeader."BA Ship-to County Fullname";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoHeaderInsert', '', false, false)]
    local procedure SalesPostOnBeforeSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("BA Bill-to County Fullname", "BA Sell-to County Fullname", "BA Ship-to County Fullname");
        SalesCrMemoHeader."BA Bill-to County Fullname" := SalesHeader."BA Bill-to County Fullname";
        SalesCrMemoHeader."BA Sell-to County Fullname" := SalesHeader."BA Sell-to County Fullname";
        SalesCrMemoHeader."BA Ship-to County Fullname" := SalesHeader."BA Ship-to County Fullname";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvBillTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesInvBillTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesInvHeader: Record "Sales Invoice Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesInvHeader."BA Bill-to County Fullname" <> '' then
            SalesInvHeader."Bill-to County" := SalesInvHeader."BA Bill-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesInvHeader."Bill-to Name", SalesInvHeader."Bill-to Name 2", SalesInvHeader."Bill-to Contact",
            SalesInvHeader."Bill-to Address", SalesInvHeader."Bill-to Address 2", SalesInvHeader."Bill-to City", SalesInvHeader."Bill-to Post Code",
            SalesInvHeader."Bill-to County", SalesInvHeader."Bill-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesCrMemoBillTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesCrMemoBillTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesCrMemoHeader."BA Bill-to County Fullname" <> '' then
            SalesCrMemoHeader."Bill-to County" := SalesCrMemoHeader."BA Bill-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesCrMemoHeader."Bill-to Name", SalesCrMemoHeader."Bill-to Name 2", SalesCrMemoHeader."Bill-to Contact",
            SalesCrMemoHeader."Bill-to Address", SalesCrMemoHeader."Bill-to Address 2", SalesCrMemoHeader."Bill-to City", SalesCrMemoHeader."Bill-to Post Code",
            SalesCrMemoHeader."Bill-to County", SalesCrMemoHeader."Bill-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderBillTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesHeaderBillTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesHeader: Record "Sales Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        SalesHeader.CalcFields("BA Bill-to County Fullname");
        if SalesHeader."BA Bill-to County Fullname" <> '' then
            SalesHeader."Bill-to County" := SalesHeader."BA Bill-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Bill-to Name", SalesHeader."Bill-to Name 2", SalesHeader."Bill-to Contact",
            SalesHeader."Bill-to Address", SalesHeader."Bill-to Address 2", SalesHeader."Bill-to City", SalesHeader."Bill-to Post Code",
            SalesHeader."Bill-to County", SalesHeader."Bill-to Country/Region Code");
    end;



    var
        NoCommissionErr: Label '%1 %2 on line %3 requires a %4.';
}