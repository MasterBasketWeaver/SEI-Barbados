tableextension 80006 "BA Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
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