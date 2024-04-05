pageextension 80047 "BA Edit G/L Entries" extends "Edit General Ledger Entries"
{
    layout
    {
        addafter("Country for Reports")
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
    }
}