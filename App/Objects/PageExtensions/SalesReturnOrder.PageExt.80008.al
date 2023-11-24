pageextension 80008 "BA Sales Return Order" extends "Sales Return Order"
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