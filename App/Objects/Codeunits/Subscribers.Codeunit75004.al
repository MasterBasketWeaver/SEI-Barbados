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







    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesShptBillTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesShptBillTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesShptHeader: Record "Sales Shipment Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesShptHeader."BA Bill-to County Fullname" <> '' then
            SalesShptHeader."Bill-to County" := SalesShptHeader."BA Bill-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesShptHeader."Bill-to Name", SalesShptHeader."Bill-to Name 2", SalesShptHeader."Bill-to Contact",
            SalesShptHeader."Bill-to Address", SalesShptHeader."Bill-to Address 2", SalesShptHeader."Bill-to City", SalesShptHeader."Bill-to Post Code",
            SalesShptHeader."Bill-to County", SalesShptHeader."Bill-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesShptShipTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesShptShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesShptHeader: Record "Sales Shipment Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesShptHeader."BA Ship-to County Fullname" <> '' then
            SalesShptHeader."Ship-to County" := SalesShptHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesShptHeader."Ship-to Name", SalesShptHeader."Ship-to Name 2", SalesShptHeader."Ship-to Contact",
            SalesShptHeader."Ship-to Address", SalesShptHeader."Ship-to Address 2", SalesShptHeader."Ship-to City", SalesShptHeader."Ship-to Post Code",
            SalesShptHeader."Ship-to County", SalesShptHeader."Ship-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesShptSellTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesShptSellTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesShptHeader: Record "Sales Shipment Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesShptHeader."BA Sell-to County Fullname" <> '' then
            SalesShptHeader."Sell-to County" := SalesShptHeader."BA Sell-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesShptHeader."Sell-to Customer Name", SalesShptHeader."Sell-to Customer Name 2", SalesShptHeader."Sell-to Contact",
            SalesShptHeader."Sell-to Address", SalesShptHeader."Sell-to Address 2", SalesShptHeader."Sell-to City", SalesShptHeader."Sell-to Post Code",
            SalesShptHeader."Sell-to County", SalesShptHeader."Sell-to Country/Region Code");
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvShipTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesInvShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesInvHeader: Record "Sales Invoice Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesInvHeader."BA Ship-to County Fullname" <> '' then
            SalesInvHeader."Ship-to County" := SalesInvHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesInvHeader."Ship-to Name", SalesInvHeader."Ship-to Name 2", SalesInvHeader."Ship-to Contact",
            SalesInvHeader."Ship-to Address", SalesInvHeader."Ship-to Address 2", SalesInvHeader."Ship-to City", SalesInvHeader."Ship-to Post Code",
            SalesInvHeader."Ship-to County", SalesInvHeader."Ship-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvSellTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesInvSellTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesInvHeader: Record "Sales Invoice Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesInvHeader."BA Sell-to County Fullname" <> '' then
            SalesInvHeader."Sell-to County" := SalesInvHeader."BA Sell-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesInvHeader."Sell-to Customer Name", SalesInvHeader."Sell-to Customer Name 2", SalesInvHeader."Sell-to Contact",
            SalesInvHeader."Sell-to Address", SalesInvHeader."Sell-to Address 2", SalesInvHeader."Sell-to City", SalesInvHeader."Sell-to Post Code",
            SalesInvHeader."Sell-to County", SalesInvHeader."Sell-to Country/Region Code");
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesCrMemoShipTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesCrMemoShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesCrMemoHeader."BA Ship-to County Fullname" <> '' then
            SalesCrMemoHeader."Ship-to County" := SalesCrMemoHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesCrMemoHeader."Ship-to Name", SalesCrMemoHeader."Ship-to Name 2", SalesCrMemoHeader."Ship-to Contact",
            SalesCrMemoHeader."Ship-to Address", SalesCrMemoHeader."Ship-to Address 2", SalesCrMemoHeader."Ship-to City", SalesCrMemoHeader."Ship-to Post Code",
            SalesCrMemoHeader."Ship-to County", SalesCrMemoHeader."Ship-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesCrMemoSellTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesCrMemoSellTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if SalesCrMemoHeader."BA Sell-to County Fullname" <> '' then
            SalesCrMemoHeader."Sell-to County" := SalesCrMemoHeader."BA Sell-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesCrMemoHeader."Sell-to Customer Name", SalesCrMemoHeader."Sell-to Customer Name 2", SalesCrMemoHeader."Sell-to Contact",
            SalesCrMemoHeader."Sell-to Address", SalesCrMemoHeader."Sell-to Address 2", SalesCrMemoHeader."Sell-to City", SalesCrMemoHeader."Sell-to Post Code",
            SalesCrMemoHeader."Sell-to County", SalesCrMemoHeader."Sell-to Country/Region Code");
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderSellTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesHeaderSellTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesHeader: Record "Sales Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        SalesHeader.CalcFields("BA Sell-to County Fullname");
        if SalesHeader."BA Sell-to County Fullname" <> '' then
            SalesHeader."Sell-to County" := SalesHeader."BA Sell-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Sell-to Customer Name", SalesHeader."Sell-to Customer Name 2", SalesHeader."Sell-to Contact",
            SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2", SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code",
            SalesHeader."Sell-to County", SalesHeader."Sell-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderShipTo', '', false, false)]
    local procedure FormatAddressOnBeforeSalesHeaderShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var SalesHeader: Record "Sales Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        SalesHeader.CalcFields("BA Ship-to County Fullname");
        if SalesHeader."BA Ship-to County Fullname" <> '' then
            SalesHeader."Ship-to County" := SalesHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, SalesHeader."Ship-to Name", SalesHeader."Ship-to Name 2", SalesHeader."Ship-to Contact",
            SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2", SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code",
            SalesHeader."Ship-to County", SalesHeader."Ship-to Country/Region Code");
    end;



    var
        NoCommissionErr: Label '%1 %2 on line %3 requires a %4.';
}