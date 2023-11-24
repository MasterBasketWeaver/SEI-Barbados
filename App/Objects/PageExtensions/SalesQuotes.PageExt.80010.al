pageextension 80010 "BA Sales Quotes" extends "Sales Quotes"
{
    layout
    {
        addafter("Document Date")
        {
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
        }
    }
}