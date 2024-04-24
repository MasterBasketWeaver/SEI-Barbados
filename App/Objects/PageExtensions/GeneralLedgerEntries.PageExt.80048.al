pageextension 80048 "BA General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("BA Prov/State for Reports"; Rec."BA Prov/State for Reports")
            {
                ApplicationArea = all;
            }
            field("BA Prov/State Name for Reports"; Rec."BA Prov/State Name for Reports")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posting Date")
        {
            field("BA Actual Posting DateTime"; Rec."BA Actual Posting DateTime")
            {
                ApplicationArea = all;
            }
        }
    }
}