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
        addlast(Control1)
        {
            field("Quote No."; Rec."Quote No.")
            {
                ApplicationArea = all;
            }
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
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
        }
    }
}