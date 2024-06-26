pageextension 80012 "BA Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field("BA Actual Posting DateTime"; Rec."BA Actual Posting DateTime")
            {
                ApplicationArea = all;
            }
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
            field("Order Date"; Rec."Order Date")
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
                CaptionClass = '80000,1';
            }
            field("Ship-to County"; Rec."Ship-to County")
            {
                ApplicationArea = all;
                Caption = 'Ship-to State';
                CaptionClass = '80000,2';
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                Editable = false;
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