tableextension 80005 "BA Sales Header" extends "Sales Header"
{
    fields
    {
        field(80010; "BA Quote Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Date';
            Editable = false;
        }
    }
}