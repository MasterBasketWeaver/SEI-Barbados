tableextension 80012 "BA Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
{
    fields
    {
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
        field(80020; "BA Ship-to FID No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to FID No.';
            Editable = false;
        }
        field(80021; "BA EORI No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'EORI No.';
            Editable = false;
        }
        field(80022; "BA Ship-to EORI No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to EORI No.';
            Editable = false;
        }
    }
}