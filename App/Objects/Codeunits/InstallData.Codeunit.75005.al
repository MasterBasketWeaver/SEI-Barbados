codeunit 75005 "BA Install Data"
{
    Subtype = Install;
    Permissions = tabledata "Sales Invoice Header" = m,
    Tabledata "Sales Shipment Header" = m,
    Tabledata "Sales Cr.Memo Header" = m;

    trigger OnInstallAppPerCompany()
    begin
        // PopulateFields();
        PopulateProvinceStateFields();
    end;


    local procedure PopulateProvinceStateFields()
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Nos: List of [Code[20]];
        RecNo: Code[20];
        ProvinceState: Record "BA Province/State";
    begin
        Customer.SetRange("BA Province/State", '');
        Customer.SetFilter(County, '<>%1', '');
        if Customer.FindSet() then
            repeat
                Nos.Add(Customer."No.");
            until Customer.Next() = 0;
        foreach RecNo in Nos do begin
            Customer.Get(RecNo);
            Customer."BA Province/State" := Customer.County;
            Customer.Modify(false);
        end;

        Clear(Nos);
        Vendor.SetRange("BA Province/State", '');
        Vendor.SetFilter(County, '<>%1', '');
        if Vendor.FindSet() then
            repeat
                Nos.Add(Vendor."No.");
            until Vendor.Next() = 0;
        foreach RecNo in Nos do begin
            Vendor.Get(RecNo);
            Vendor."BA Province/State" := Vendor.County;
            Vendor.Modify(false);
        end;


        ProvinceState.SetRange("Print Full Name", true);
        if ProvinceState.FindSet() then
            repeat
                SalesInvHeader.SetRange("Bill-to County", ProvinceState.Symbol);
                SalesInvHeader.ModifyAll("BA Bill-to County Fullname", ProvinceState.Name);
                SalesInvHeader.Reset();
                SalesInvHeader.SetRange("Sell-to County", ProvinceState.Symbol);
                SalesInvHeader.ModifyAll("BA Sell-to County Fullname", ProvinceState.Name);
                SalesInvHeader.Reset();
                SalesInvHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                SalesInvHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                SalesInvHeader.Reset();

                SalesCrMemoHeader.SetRange("Bill-to County", ProvinceState.Symbol);
                SalesCrMemoHeader.ModifyAll("BA Bill-to County Fullname", ProvinceState.Name);
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("Sell-to County", ProvinceState.Symbol);
                SalesCrMemoHeader.ModifyAll("BA Sell-to County Fullname", ProvinceState.Name);
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                SalesCrMemoHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                SalesCrMemoHeader.Reset();

                SalesShptHeader.SetRange("Bill-to County", ProvinceState.Symbol);
                SalesShptHeader.ModifyAll("BA Bill-to County Fullname", ProvinceState.Name);
                SalesShptHeader.Reset();
                SalesShptHeader.SetRange("Sell-to County", ProvinceState.Symbol);
                SalesShptHeader.ModifyAll("BA Sell-to County Fullname", ProvinceState.Name);
                SalesShptHeader.Reset();
                SalesShptHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                SalesShptHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                SalesShptHeader.Reset();
            until ProvinceState.Next() = 0;
    end;

    local procedure PopulateFields()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempSalesInvHeader: Record "Sales Invoice Header" temporary;
    begin
        SalesInvoiceHeader.SetRange("BA Posting Date", 0D);
        if not SalesInvoiceHeader.FindSet() then
            exit;
        repeat
            TempSalesInvHeader."No." := SalesInvoiceHeader."No.";
            TempSalesInvHeader.Insert(false);
        until SalesInvoiceHeader.Next() = 0;

        if not TempSalesInvHeader.FindSet() then
            exit;
        repeat
            SalesInvoiceHeader.Get(TempSalesInvHeader."No.");
            SalesInvoiceHeader."BA Order No." := SalesInvoiceHeader."Order No.";
            SalesInvoiceHeader."BA Posting Date" := SalesInvoiceHeader."Posting Date";
            SalesInvoiceHeader."BA Sell-to Customer No." := SalesInvoiceHeader."Sell-to Customer No.";
            SalesInvoiceHeader."BA Sell-to Customer Name" := SalesInvoiceHeader."Sell-to Customer Name";
            SalesInvoiceHeader."BA Ship-to Name" := SalesInvoiceHeader."Ship-to Name";
            SalesInvoiceHeader.Modify(false);
        until TempSalesInvHeader.Next() = 0;
    end;
}