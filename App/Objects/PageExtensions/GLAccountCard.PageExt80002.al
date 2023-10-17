pageextension 80002 "BA G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("BA Require Commission No."; Rec."BA Require Commission No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies if the Commission Invoice No. field is required for Purchase Orders using this G/L Account.';
            }
        }
    }
}