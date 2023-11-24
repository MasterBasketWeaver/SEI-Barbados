pageextension 80009 "BA Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter("Document Date")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
        }
    }
}