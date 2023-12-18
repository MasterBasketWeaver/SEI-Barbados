pageextension 80041 "BA Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
                Caption = 'Created Date';
            }
            field("BA Created By"; Rec."BA Created By")
            {
                ApplicationArea = all;
            }
        }
    }
}