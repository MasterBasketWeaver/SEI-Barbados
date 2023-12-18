pageextension 80040 "BA Item List" extends "Item List"
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
            field("Omit from Data Sync"; Rec."Omit from Data Sync")
            {
                ApplicationArea = all;
            }
        }
    }
}