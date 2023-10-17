codeunit 75005 "BA Populate DropDown Fields"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        PopulateFields();
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