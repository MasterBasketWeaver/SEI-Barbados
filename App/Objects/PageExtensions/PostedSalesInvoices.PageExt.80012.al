pageextension 80012 "BA Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
        }
    }
}