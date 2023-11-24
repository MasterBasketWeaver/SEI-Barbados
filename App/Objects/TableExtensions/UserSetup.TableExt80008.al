tableextension 80008 "BA User Setup" extends "User Setup"
{
    fields
    {
        field(80000; "BA Allow Changing Counties"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Changing Counties';
        }
        field(80001; "BA Allow Changing Regions"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Changing Regions';
        }
    }
}