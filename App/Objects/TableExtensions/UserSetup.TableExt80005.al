tableextension 80011 "BA User Setup" extends "User Setup"
{
    fields
    {
        field(80000; "BA Allow Changing Counties"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Changing States';
        }
        field(80001; "BA Allow Changing Regions"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Changing Regions';
        }
        field(80002; "BA Allow Changing Countries"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Changing Countries';
        }
    }
}