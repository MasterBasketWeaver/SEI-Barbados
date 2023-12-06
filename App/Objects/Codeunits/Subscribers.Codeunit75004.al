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









    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure PurchPostOnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header")
    begin
        PurchHeader.CalcFields("BA Pay-to County Fullname", "BA Buy-from County Fullname", "BA Ship-to County Fullname");
        PurchInvHeader."BA Pay-to County Fullname" := PurchHeader."BA Pay-to County Fullname";
        PurchInvHeader."BA Buy-from County Fullname" := PurchHeader."BA Buy-from County Fullname";
        PurchInvHeader."BA Ship-to County Fullname" := PurchHeader."BA Ship-to County Fullname";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure PurchPostOnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.CalcFields("BA Pay-to County Fullname", "BA Buy-from County Fullname", "BA Ship-to County Fullname");
        PurchRcptHeader."BA Pay-to County Fullname" := PurchaseHeader."BA Pay-to County Fullname";
        PurchRcptHeader."BA Buy-from County Fullname" := PurchaseHeader."BA Buy-from County Fullname";
        PurchRcptHeader."BA Ship-to County Fullname" := PurchaseHeader."BA Ship-to County Fullname";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', false, false)]
    local procedure PurchPostOnBeforePurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header")
    begin
        PurchHeader.CalcFields("BA Pay-to County Fullname", "BA Buy-from County Fullname", "BA Ship-to County Fullname");
        PurchCrMemoHdr."BA Pay-to County Fullname" := PurchHeader."BA Pay-to County Fullname";
        PurchCrMemoHdr."BA Buy-from County Fullname" := PurchHeader."BA Buy-from County Fullname";
        PurchCrMemoHdr."BA Ship-to County Fullname" := PurchHeader."BA Ship-to County Fullname";
    end;






    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchRcptBuyFrom', '', false, false)]
    local procedure FormatAddressOnBeforePurchRcptBuyFrom(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchRcptHeader."BA Buy-from County Fullname" <> '' then
            PurchRcptHeader."Buy-from County" := PurchRcptHeader."BA Buy-from County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchRcptHeader."Buy-from Vendor Name", PurchRcptHeader."Buy-from Vendor Name 2", PurchRcptHeader."Buy-from Contact",
            PurchRcptHeader."Buy-from Address", PurchRcptHeader."Buy-from Address 2", PurchRcptHeader."Buy-from City", PurchRcptHeader."Buy-from Post Code",
            PurchRcptHeader."Buy-from County", PurchRcptHeader."Buy-from Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchRcptShipTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchRcptShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchRcptHeader."BA Ship-to County Fullname" <> '' then
            PurchRcptHeader."Ship-to County" := PurchRcptHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchRcptHeader."Ship-to Name", PurchRcptHeader."Ship-to Name 2", PurchRcptHeader."Ship-to Contact",
            PurchRcptHeader."Ship-to Address", PurchRcptHeader."Ship-to Address 2", PurchRcptHeader."Ship-to City", PurchRcptHeader."Ship-to Post Code",
            PurchRcptHeader."Ship-to County", PurchRcptHeader."Ship-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchRcptPayTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchRcptPayTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchRcptHeader."BA Pay-to County Fullname" <> '' then
            PurchRcptHeader."Pay-to County" := PurchRcptHeader."BA Pay-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchRcptHeader."Pay-to Name", PurchRcptHeader."Pay-to Name 2", PurchRcptHeader."Pay-to Contact",
            PurchRcptHeader."Pay-to Address", PurchRcptHeader."Pay-to Address 2", PurchRcptHeader."Pay-to City", PurchRcptHeader."Pay-to Post Code",
            PurchRcptHeader."Pay-to County", PurchRcptHeader."Pay-to Country/Region Code");
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchInvBuyFrom', '', false, false)]
    local procedure FormatAddressOnBeforePurchInvBuyFrom(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchInvHeader."BA Buy-from County Fullname" <> '' then
            PurchInvHeader."Buy-from County" := PurchInvHeader."BA Buy-from County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchInvHeader."Buy-from Vendor Name", PurchInvHeader."Buy-from Vendor Name 2", PurchInvHeader."Buy-from Contact",
            PurchInvHeader."Buy-from Address", PurchInvHeader."Buy-from Address 2", PurchInvHeader."Buy-from City", PurchInvHeader."Buy-from Post Code",
            PurchInvHeader."Buy-from County", PurchInvHeader."Buy-from Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchInvShipTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchInvShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchInvHeader."BA Ship-to County Fullname" <> '' then
            PurchInvHeader."Ship-to County" := PurchInvHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchInvHeader."Ship-to Name", PurchInvHeader."Ship-to Name 2", PurchInvHeader."Ship-to Contact",
            PurchInvHeader."Ship-to Address", PurchInvHeader."Ship-to Address 2", PurchInvHeader."Ship-to City", PurchInvHeader."Ship-to Post Code",
            PurchInvHeader."Ship-to County", PurchInvHeader."Ship-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchInvPayTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchInvPayTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchInvHeader."BA Pay-to County Fullname" <> '' then
            PurchInvHeader."Pay-to County" := PurchInvHeader."BA Pay-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchInvHeader."Pay-to Name", PurchInvHeader."Pay-to Name 2", PurchInvHeader."Pay-to Contact",
            PurchInvHeader."Pay-to Address", PurchInvHeader."Pay-to Address 2", PurchInvHeader."Pay-to City", PurchInvHeader."Pay-to Post Code",
            PurchInvHeader."Pay-to County", PurchInvHeader."Pay-to Country/Region Code");
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchCrMemoBuyFrom', '', false, false)]
    local procedure FormatAddressOnBeforePurchCrMemoBuyFrom(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchCrMemoHeader."BA Buy-from County Fullname" <> '' then
            PurchCrMemoHeader."Buy-from County" := PurchCrMemoHeader."BA Buy-from County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchCrMemoHeader."Buy-from Vendor Name", PurchCrMemoHeader."Buy-from Vendor Name 2", PurchCrMemoHeader."Buy-from Contact",
            PurchCrMemoHeader."Buy-from Address", PurchCrMemoHeader."Buy-from Address 2", PurchCrMemoHeader."Buy-from City", PurchCrMemoHeader."Buy-from Post Code",
            PurchCrMemoHeader."Buy-from County", PurchCrMemoHeader."Buy-from Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchCrMemoShipTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchCrMemoShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchCrMemoHeader."BA Ship-to County Fullname" <> '' then
            PurchCrMemoHeader."Ship-to County" := PurchCrMemoHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchCrMemoHeader."Ship-to Name", PurchCrMemoHeader."Ship-to Name 2", PurchCrMemoHeader."Ship-to Contact",
            PurchCrMemoHeader."Ship-to Address", PurchCrMemoHeader."Ship-to Address 2", PurchCrMemoHeader."Ship-to City", PurchCrMemoHeader."Ship-to Post Code",
            PurchCrMemoHeader."Ship-to County", PurchCrMemoHeader."Ship-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchCrMemoPayTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchCrMemoPayTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        if PurchCrMemoHeader."BA Pay-to County Fullname" <> '' then
            PurchCrMemoHeader."Pay-to County" := PurchCrMemoHeader."BA Pay-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchCrMemoHeader."Pay-to Name", PurchCrMemoHeader."Pay-to Name 2", PurchCrMemoHeader."Pay-to Contact",
            PurchCrMemoHeader."Pay-to Address", PurchCrMemoHeader."Pay-to Address 2", PurchCrMemoHeader."Pay-to City", PurchCrMemoHeader."Pay-to Post Code",
            PurchCrMemoHeader."Pay-to County", PurchCrMemoHeader."Pay-to Country/Region Code");
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderBuyFrom', '', false, false)]
    local procedure FormatAddressOnBeforePurchHeaderBuyFrom(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchHeader: Record "Purchase Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        PurchHeader.CalcFields("BA Buy-from County Fullname");
        if PurchHeader."BA Buy-from County Fullname" <> '' then
            PurchHeader."Buy-from County" := PurchHeader."BA Buy-from County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchHeader."Buy-from Vendor Name", PurchHeader."Buy-from Vendor Name 2", PurchHeader."Buy-from Contact",
            PurchHeader."Buy-from Address", PurchHeader."Buy-from Address 2", PurchHeader."Buy-from City", PurchHeader."Buy-from Post Code",
            PurchHeader."Buy-from County", PurchHeader."Buy-from Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderPayTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchHeaderPayTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchHeader: Record "Purchase Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        PurchHeader.CalcFields("BA Pay-to County Fullname");
        if PurchHeader."BA Pay-to County Fullname" <> '' then
            PurchHeader."Pay-to County" := PurchHeader."BA Pay-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchHeader."Pay-to Name", PurchHeader."Pay-to Name 2", PurchHeader."Pay-to Contact",
            PurchHeader."Pay-to Address", PurchHeader."Pay-to Address 2", PurchHeader."Pay-to City", PurchHeader."Pay-to Post Code",
            PurchHeader."Pay-to County", PurchHeader."Pay-to Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderShipTo', '', false, false)]
    local procedure FormatAddressOnBeforePurchHeaderShipTo(var AddrArray: array[8] of Text[90]; var Handled: Boolean; var PurchHeader: Record "Purchase Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        Handled := true;
        PurchHeader.CalcFields("BA Ship-to County Fullname");
        if PurchHeader."BA Ship-to County Fullname" <> '' then
            PurchHeader."Ship-to County" := PurchHeader."BA Ship-to County Fullname";
        FormatAddress.FormatAddr(AddrArray, PurchHeader."Ship-to Name", PurchHeader."Ship-to Name 2", PurchHeader."Ship-to Contact",
            PurchHeader."Ship-to Address", PurchHeader."Ship-to Address 2", PurchHeader."Ship-to City", PurchHeader."Ship-to Post Code",
            PurchHeader."Ship-to County", PurchHeader."Ship-to Country/Region Code");
    end;







    var
        NoCommissionErr: Label '%1 %2 on line %3 requires a %4.';
}