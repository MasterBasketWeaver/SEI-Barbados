codeunit 75005 "BA Install Data"
{
    Subtype = Install;
    Permissions = tabledata "Sales Invoice Header" = m,
    Tabledata "Sales Shipment Header" = m,
    Tabledata "Sales Cr.Memo Header" = m,
    // tabledata "BA Province/State" = rimd,
    tabledata "Purch. Inv. Header" = m,
    tabledata "Purch. Rcpt. Header" = m,
    tabledata "Purch. Cr. Memo Hdr." = m,
    tabledata Item = m;

    trigger OnInstallAppPerCompany()
    begin
        // PopulateFields();
        // PopulateStates(false);
        // PopulateProvinceStateFields('');
        PopulateItemCreatedDates();
    end;

    local procedure PopulateItemCreatedDates()
    var
        Item: Record Item;
    begin
        Item.SetRange("BA Created By", '');
        Item.ModifyAll("BA Created By", 'SYSTEM');
        Item.Reset();
        Item.SetRange("BA Created At", 0D);
        Item.ModifyAll("BA Created At", Today());
    end;
}