pageextension 80001 "BA Posted Purch. Inv. Subpage" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("BA Commission Invoice No."; Rec."BA Commission Invoice No.")
            {
                ApplicationArea = all;
            }
        }
    }
}