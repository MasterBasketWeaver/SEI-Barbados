pageextension 80043 "BA Customer List" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field("BA SEI Service Center"; Rec."BA SEI Service Center")
            {
                ApplicationArea = all;
            }
        }
    }
}