pageextension 80042 "BA Vendor List" extends "Vendor List"
{
    layout
    {
        addlast(Control1)
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