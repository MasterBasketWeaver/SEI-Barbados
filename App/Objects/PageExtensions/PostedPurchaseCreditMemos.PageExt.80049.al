pageextension 80049 "BA Posted Purchase Memos" extends "Posted Purchase Credit Memos"
{
    layout
    {
        addlast(Control1)
        {
            field("User ID"; Rec."User ID")
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