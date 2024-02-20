pageextension 80045 "BA Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    layout
    {
        addlast(Control1)
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
}