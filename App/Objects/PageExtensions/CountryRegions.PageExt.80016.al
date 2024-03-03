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