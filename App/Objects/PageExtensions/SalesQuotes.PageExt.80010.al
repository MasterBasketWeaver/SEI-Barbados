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
        addlast(Control1)
        {
            field("Sell-to County"; Rec."Sell-to County")
            {
                ApplicationArea = all;
            }
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = all;
            }
        }
    }
}