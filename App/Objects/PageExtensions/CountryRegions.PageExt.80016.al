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
}