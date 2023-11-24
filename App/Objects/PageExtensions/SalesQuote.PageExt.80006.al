pageextension 80006 "BA Sales Quote" extends "Sales Quote"
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