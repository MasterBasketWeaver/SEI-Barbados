pageextension 80011 "BA Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Document Date")
        {
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }
    }
}