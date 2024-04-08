pageextension 80016 "BA Country/Regions" extends "Countries/Regions"
{
    Caption = 'Countries';

    layout
    {
        addafter(Name)
        {
            field("BA Region"; Rec."BA Region")
            {
                ApplicationArea = all;
            }
        }
        addlast(Control1)
        {
            field("BA Sell-to State Mandatory"; Rec."BA Sell-to State Mandatory")
            {
                ApplicationArea = all;
            }
            field("BA Ship-to State Mandatory"; Rec."BA Ship-to State Mandatory")
            {
                ApplicationArea = all;
            }
            field("BA FID No. Mandatory"; Rec."BA FID No. Mandatory")
            {
                ApplicationArea = all;
            }
            field("BA Sell-to EORI No."; Rec."BA EORI No. Mandatory")
            {
                ApplicationArea = all;
            }
            field("BA Country Agent"; Rec."BA Country Agent")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("BA Add States/Provinces")
            {
                ApplicationArea = all;
                Image = Addresses;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Add States/Provinces';

                trigger OnAction()
                var
                    Install: Codeunit "BA Install Data";
                begin
                    Install.PopulateStates(true);
                end;
            }
        }
    }
}