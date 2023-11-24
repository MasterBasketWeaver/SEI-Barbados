pageextension 80009 "BA Sales Order List" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }
    }
}