pageextension 80010 "BA Sales Quotes" extends "Sales Quotes"
{
    layout
    {

        addlast(Control1)
        {
            field("Sell-to County"; Rec."Sell-to County")
            {
                ApplicationArea = all;
                Caption = 'Sell-to State';
            }
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = all;
                Caption = 'Ship-to State';
            }
        }
    }
}