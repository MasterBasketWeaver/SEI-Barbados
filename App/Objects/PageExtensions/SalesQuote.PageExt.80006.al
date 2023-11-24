pageextension 80006 "BA Sales Quote" extends "Sales Quote"
{
    layout
    {
        modify("Order Date")
        {
            ApplicationArea = all;
            Editable = false;
        }
        modify("Shipment Date")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Document Date")
        {
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
        }
    }
}