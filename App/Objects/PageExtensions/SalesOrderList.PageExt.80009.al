pageextension 80009 "BA Sales Order List" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Quote No."; Rec."Quote No.")
            {
                ApplicationArea = all;
            }
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