tableextension 80001 "BA G/L Account" extends "G/L Account"
{
    fields
    {
        field(80000; "BA Require Commission No."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Require Commission No.';
        }
    }
}