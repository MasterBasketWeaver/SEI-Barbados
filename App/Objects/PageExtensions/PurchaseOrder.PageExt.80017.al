pageextension 80017 "BA Purchase Order" extends "Purchase Order"
{
    layout
    {
        modify("Assigned User ID")
        {
            ApplicationArea = all;
            Editable = false;
        }
    }
}