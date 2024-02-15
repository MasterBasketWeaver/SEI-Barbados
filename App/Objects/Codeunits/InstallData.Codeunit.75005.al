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
        PopulateVendorCreatedDates();
    end;

    local procedure PopulateItemCreatedDates()
    var
        Item: Record Item;
        Items: List of [Code[20]];
        ItemNo: Code[20];
    begin
        Item.SetRange("BA Created By", '');
        Item.SetRange("BA Created At", 0D);
        if Item.FindSet() then
            repeat
                Items.Add(Item."No.");
            until Item.Next() = 0;

        foreach ItemNo in Items do begin
            Item.Get(ItemNo);
            Item."BA Created By" := 'SYSTEM';
            Item."BA Created At" := Today();
            Item.Modify(false);
        end;
    end;

    local procedure PopulateVendorCreatedDates()
    var
        Vendor: Record Vendor;
        Vendors: List of [Code[20]];
        VendorNo: Code[20];
    begin
        Vendor.SetRange("BA Created By", '');
        Vendor.SetRange("BA Created At", 0D);
        if Vendor.FindSet() then
            repeat
                Vendors.Add(Vendor."No.");
            until Vendor.Next() = 0;

        foreach VendorNo in Vendors do begin
            Vendor.Get(VendorNo);
            Vendor."BA Created By" := 'SYSTEM';
            Vendor."BA Created At" := Today();
            Vendor.Modify(false);
        end;
    end;
}