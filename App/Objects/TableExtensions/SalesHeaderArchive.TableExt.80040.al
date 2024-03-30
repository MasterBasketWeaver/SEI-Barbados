tableextension 80040 "BA Sales Header Archive" extends "Sales Header Archive"
{
    fields
    {
        field(75000; "ENC Phone No."; Code[20])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75001; "ENC Ship-To Phone No."; Code[20])
        {
            Caption = 'Ship-To Phone No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75002; "ENC Tax Registration No."; Text[20])
        {
            Caption = 'FID No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75003; "ENC Ship-To Tax Reg. No."; Text[20])
        {
            Caption = 'Ship-To FID No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75010; "ENC Probability"; Decimal)
        {
            Caption = 'Probability %';
            DecimalPlaces = 0 : 2;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75035; "ENC Stage"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Stage';
            Editable = false;
            OptionMembers = " ","Open","Closed/Lost","Closed/Other","Archive";
            OptionCaption = ' ,Open,Closed/Lost,Closed/Other,Archive';
        }
        // field(75036; "ENC Timeline"; Enum "BA Timeline")
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Timeline';
        //     Editable = false;
        // }
        field(75037; "ENC Lead Time"; Code[20])
        {
            Caption = 'Lead Time';
            TableRelation = "ENC Lead Time".Code;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75038; "Freight Quote No."; Text[14])
        {
            Caption = 'Freight Quote No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75039; "Freight Account No."; Text[14])
        {
            Caption = 'Freight Account No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75040; "Inco Terms"; Code[10])
        {
            Caption = 'Inco Terms';
            TableRelation = "Inco Tems".Code;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75041; "Freight Terms"; Code[10])
        {
            TableRelation = "Freight Terms".Code;
            Caption = 'Freight Terms';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75042; "Other Tax No."; Text[30])
        {
            Caption = 'Other Tax No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(75043; "Other Ship-To Tax No."; Text[30])
        {
            Caption = 'Other Ship-To Tax No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80010; "BA Quote Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Date';
            Editable = false;
        }
        field(80011; "BA Sell-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80012; "BA Bill-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80013; "BA Ship-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
    }
}