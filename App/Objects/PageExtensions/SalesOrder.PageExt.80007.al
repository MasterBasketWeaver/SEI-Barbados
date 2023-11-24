pageextension 80007 "BA Sales Order" extends "Sales Order"
{
    layout
    {
        modify("Order Date")
        {
            ApplicationArea = all;
            Editable = false;
        }
    }
}