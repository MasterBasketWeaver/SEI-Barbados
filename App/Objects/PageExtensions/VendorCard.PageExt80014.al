pageextension 80014 "BA Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("BA Created At"; Rec."BA Created At")
            {
                ApplicationArea = all;
            }
            field("BA Created By"; Rec."BA Created By")
            {
                ApplicationArea = all;
            }
        }
    }
}