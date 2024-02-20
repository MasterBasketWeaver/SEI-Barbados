pageextension 80044 "BA Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }
    }
}