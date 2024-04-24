pageextension 80050 "BA Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BA Actual Posting DateTime"; Rec."BA Actual Posting DateTime")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("BA Updated Document Dates")
            {
                ApplicationArea = all;
                Image = UpdateDescription;
                RunObject = codeunit "BA Fix Doc. Date";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Update Document Dates';
            }
        }
    }
}