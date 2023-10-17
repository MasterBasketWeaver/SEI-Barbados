pageextension 80005 "BA P. Purch. Cr.Memo Subpage" extends "Posted Purch. Cr. Memo Subform"
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