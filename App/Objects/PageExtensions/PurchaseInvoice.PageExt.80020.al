pageextension 80020 "BA Purchase Invoice" extends "Purchase Invoice"
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