codeunit 75005 "BA Install Data"
{
    Subtype = Install;
    Permissions = tabledata "Sales Invoice Header" = m,
    Tabledata "Sales Shipment Header" = m,
    Tabledata "Sales Cr.Memo Header" = m,
    tabledata "BA Province/State" = rimd,
    tabledata "Purch. Inv. Header" = m,
    tabledata "Purch. Rcpt. Header" = m,
    tabledata "Purch. Cr. Memo Hdr." = m;

    trigger OnInstallAppPerCompany()
    begin
        // PopulateFields();
        // PopulateStates(false);
        // PopulateProvinceStateFields('');
        // PopulateItemCreatedDates();
        // PopulateVendorCreatedDates();
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
        PopulateStates(false);
        PopulateProvinceStateFields('');
    end;


    procedure PopulateProvinceStateFields(Filter: Text)
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
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

        if Filter <> '' then
            ProvinceState.SetRange(Symbol, Filter);
        ProvinceState.SetRange("Print Full Name", true);
        if ProvinceState.FindSet() then
            repeat
                SalesInvHeader.SetRange("Bill-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesInvHeader.SetRange("Bill-to County", ProvinceState.Symbol);
                SalesInvHeader.SetRange("BA Bill-to County Fullname", '');
                SalesInvHeader.ModifyAll("BA Bill-to County Fullname", ProvinceState.Name);
                SalesInvHeader.Reset();
                SalesInvHeader.SetRange("Sell-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesInvHeader.SetRange("Sell-to County", ProvinceState.Symbol);
                SalesInvHeader.SetRange("BA Sell-to County Fullname", '');
                SalesInvHeader.ModifyAll("BA Sell-to County Fullname", ProvinceState.Name);
                SalesInvHeader.Reset();
                SalesInvHeader.SetRange("Ship-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesInvHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                SalesInvHeader.SetRange("BA Ship-to County Fullname", '');
                SalesInvHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                SalesInvHeader.Reset();

                SalesCrMemoHeader.SetRange("Bill-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesCrMemoHeader.SetRange("Bill-to County", ProvinceState.Symbol);
                SalesCrMemoHeader.SetRange("BA Bill-to County Fullname", '');
                SalesCrMemoHeader.ModifyAll("BA Bill-to County Fullname", ProvinceState.Name);
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("Sell-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesCrMemoHeader.SetRange("Sell-to County", ProvinceState.Symbol);
                SalesCrMemoHeader.SetRange("BA Sell-to County Fullname", '');
                SalesCrMemoHeader.ModifyAll("BA Sell-to County Fullname", ProvinceState.Name);
                SalesCrMemoHeader.Reset();
                SalesCrMemoHeader.SetRange("Ship-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesCrMemoHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                SalesCrMemoHeader.SetRange("BA Ship-to County Fullname", '');
                SalesCrMemoHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                SalesCrMemoHeader.Reset();

                SalesShptHeader.SetRange("Bill-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesShptHeader.SetRange("Bill-to County", ProvinceState.Symbol);
                SalesShptHeader.SetRange("BA Bill-to County Fullname", '');
                SalesShptHeader.ModifyAll("BA Bill-to County Fullname", ProvinceState.Name);
                SalesShptHeader.Reset();
                SalesShptHeader.SetRange("Sell-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesShptHeader.SetRange("Sell-to County", ProvinceState.Symbol);
                SalesShptHeader.SetRange("BA Sell-to County Fullname", '');
                SalesShptHeader.ModifyAll("BA Sell-to County Fullname", ProvinceState.Name);
                SalesShptHeader.Reset();
                SalesShptHeader.SetRange("Ship-to Country/Region Code", ProvinceState."Country/Region Code");
                SalesShptHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                SalesShptHeader.SetRange("BA Ship-to County Fullname", '');
                SalesShptHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                SalesShptHeader.Reset();

                PurchInvHeader.SetRange("Buy-from Country/Region Code", ProvinceState."Country/Region Code");
                PurchInvHeader.SetRange("Buy-from County", ProvinceState.Symbol);
                PurchInvHeader.SetRange("BA Buy-from County Fullname", '');
                PurchInvHeader.ModifyAll("BA Buy-from County Fullname", ProvinceState.Name);
                PurchInvHeader.Reset();
                PurchInvHeader.SetRange("Pay-to Country/Region Code", ProvinceState."Country/Region Code");
                PurchInvHeader.SetRange("Pay-to County", ProvinceState.Symbol);
                PurchInvHeader.SetRange("BA Pay-to County Fullname", '');
                PurchInvHeader.ModifyAll("BA Pay-to County Fullname", ProvinceState.Name);
                PurchInvHeader.Reset();
                PurchInvHeader.SetRange("Ship-to Country/Region Code", ProvinceState."Country/Region Code");
                PurchInvHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                PurchInvHeader.SetRange("BA Ship-to County Fullname", '');
                PurchInvHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                PurchInvHeader.Reset();

                PurchCrMemoHeader.SetRange("Buy-from Country/Region Code", ProvinceState."Country/Region Code");
                PurchCrMemoHeader.SetRange("Buy-from County", ProvinceState.Symbol);
                PurchCrMemoHeader.SetRange("BA Buy-from County Fullname", '');
                PurchCrMemoHeader.ModifyAll("BA Buy-from County Fullname", ProvinceState.Name);
                PurchCrMemoHeader.Reset();
                PurchCrMemoHeader.SetRange("Pay-to Country/Region Code", ProvinceState."Country/Region Code");
                PurchCrMemoHeader.SetRange("Pay-to County", ProvinceState.Symbol);
                PurchCrMemoHeader.SetRange("BA Pay-to County Fullname", '');
                PurchCrMemoHeader.ModifyAll("BA Pay-to County Fullname", ProvinceState.Name);
                PurchCrMemoHeader.Reset();
                PurchCrMemoHeader.SetRange("Ship-to Country/Region Code", ProvinceState."Country/Region Code");
                PurchCrMemoHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                PurchCrMemoHeader.SetRange("BA Ship-to County Fullname", '');
                PurchCrMemoHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                PurchCrMemoHeader.Reset();

                PurchRcptHeader.SetRange("Buy-from Country/Region Code", ProvinceState."Country/Region Code");
                PurchRcptHeader.SetRange("Buy-from County", ProvinceState.Symbol);
                PurchRcptHeader.SetRange("BA Buy-from County Fullname", '');
                PurchRcptHeader.ModifyAll("BA Buy-from County Fullname", ProvinceState.Name);
                PurchRcptHeader.Reset();
                PurchRcptHeader.SetRange("Pay-to Country/Region Code", ProvinceState."Country/Region Code");
                PurchRcptHeader.SetRange("Pay-to County", ProvinceState.Symbol);
                PurchRcptHeader.SetRange("BA Pay-to County Fullname", '');
                PurchRcptHeader.ModifyAll("BA Pay-to County Fullname", ProvinceState.Name);
                PurchRcptHeader.Reset();
                PurchRcptHeader.SetRange("Ship-to Country/Region Code", ProvinceState."Country/Region Code");
                PurchRcptHeader.SetRange("Ship-to County", ProvinceState.Symbol);
                PurchRcptHeader.SetRange("BA Ship-to County Fullname", '');
                PurchRcptHeader.ModifyAll("BA Ship-to County Fullname", ProvinceState.Name);
                PurchRcptHeader.Reset();
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


    procedure PopulateStates(Manual: Boolean)
    var
        UserSetup: Record "User Setup";
        ProvState: Record "BA Province/State";
        Countries: List of [Code[10]];
        States: array[5, 100] of Code[30];
        Names: array[5, 100] of Text[50];
        Country: Code[10];
        i: Integer;
        i2: Integer;
        i3: Integer;
    begin
        if Manual then begin
            if not UserSetup.Get(UserId()) then begin
                UserSetup.Validate("User ID", UserId());
                UserSetup.Insert(true);
            end;
            UserSetup."BA Allow Changing Counties" := true;
            UserSetup."BA Allow Changing Regions" := true;
            UserSetup.Modify(true);
        end;

        Countries.Add('CA');
        Countries.Add('US');

        AddCodeValue(States, 1, i, 'BC');
        AddCodeValue(States, 1, i, 'AB');
        AddCodeValue(States, 1, i, 'SK');
        AddCodeValue(States, 1, i, 'MB');
        AddCodeValue(States, 1, i, 'ONT');
        AddCodeValue(States, 1, i, 'ON');
        AddCodeValue(States, 1, i, 'QC');
        AddCodeValue(States, 1, i, 'QB');
        AddCodeValue(States, 1, i, 'NS');
        AddCodeValue(States, 1, i, 'NB');
        AddCodeValue(States, 1, i, 'NFL');
        AddCodeValue(States, 1, i, 'PEI');
        AddTextValue(Names, 1, i2, 'British Columbia');
        AddTextValue(Names, 1, i2, 'Alberta');
        AddTextValue(Names, 1, i2, 'Saskatchewan');
        AddTextValue(Names, 1, i2, 'Manitoba');
        AddTextValue(Names, 1, i2, 'Ontario');
        AddTextValue(Names, 1, i2, 'Ontario');
        AddTextValue(Names, 1, i2, 'Quebec');
        AddTextValue(Names, 1, i2, 'Quebec');
        AddTextValue(Names, 1, i2, 'Nova Scotia');
        AddTextValue(Names, 1, i2, 'New Brunswick');
        AddTextValue(Names, 1, i2, 'Newfoundland');
        AddTextValue(Names, 1, i2, 'Prince Edward Island');

        AddCodeValue(States, 2, i, 'TX');
        AddCodeValue(States, 2, i, 'CA');
        AddCodeValue(States, 2, i, 'WA');
        AddCodeValue(States, 2, i, 'NJ');
        AddTextValue(Names, 2, i2, 'Texas');
        AddTextValue(Names, 2, i2, 'California');
        AddTextValue(Names, 2, i2, 'Washington');
        AddTextValue(Names, 2, i2, 'New Jersey');

        foreach Country in Countries do begin
            i3 += 1;
            for i := 1 to 100 do
                if States[i3, i] <> '' then
                    if not ProvState.Get(Country, States[i3, i]) then begin
                        ProvState.Init();
                        ProvState.Validate("Country/Region Code", Country);
                        ProvState.Validate(Symbol, States[i3, i]);
                        ProvState.Validate(Name, Names[i3, i]);
                        ProvState."Print Full Name" := true;
                        ProvState.Insert(true);
                    end;
        end;

        if Manual then
            PopulateProvinceStateFields('');
    end;

    local procedure AddCodeValue(var CodeArray: array[5, 100] of Code[30]; Index: Integer; var i: Integer; Input: Code[30])
    begin
        i += 1;
        CodeArray[Index, i] := Input;
    end;

    local procedure AddTextValue(var CodeArray: array[5, 100] of Text[50]; Index: Integer; var i: Integer; Input: Text[50])
    begin
        i += 1;
        CodeArray[Index, i] := Input;
    end;
}