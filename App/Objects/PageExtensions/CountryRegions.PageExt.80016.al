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