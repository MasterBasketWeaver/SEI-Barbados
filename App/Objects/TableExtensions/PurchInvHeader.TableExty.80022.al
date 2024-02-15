tableextension 80022 "BA Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(80011; "BA Pay-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80012; "BA Buy-from County Fullname"; Text[50])
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