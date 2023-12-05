tableextension 80006 "BA Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(80010; "BA Quote Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Date';
            Editable = false;
            //
        }
    }
}