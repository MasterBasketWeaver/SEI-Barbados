pageextension 80041 "BA Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("BA Created At"; Rec."BA Created At")
            {
                ApplicationArea = all;
            }
            field("BA Created By"; Rec."BA Created By")
            {
                ApplicationArea = all;
            }
        }
    }
}