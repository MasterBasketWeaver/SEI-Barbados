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
        addafter("Qty. on Asm. Component")
        {
            field("BA Qty. on Sales Quote"; Rec."BA Qty. on Sales Quote")
            {
                ApplicationArea = all;
            }
            field("BA Qty. on Closed Sales Quote"; Rec."BA Qty. on Closed Sales Quote")
            {
                ApplicationArea = all;
            }
        }
        addafter(Blocked)
        {
            field("BA Service Item Only"; Rec."BA Service Item Only")
            {
                ApplicationArea = all;
            }
        }
    }
}