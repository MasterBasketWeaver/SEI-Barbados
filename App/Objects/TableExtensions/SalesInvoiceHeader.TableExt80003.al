tableextension 80003 "BA Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(80000; "BA Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
            Editable = false;
            Description = 'Used for DropDown FieldGroup';
        }
        field(80001; "BA Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No.';
            Editable = false;
            Description = 'Used for DropDown FieldGroup';
        }
        field(80002; "BA Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer No.';
            Editable = false;
            Description = 'Used for DropDown FieldGroup';
        }
        field(80003; "BA Sell-to Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name';
            Editable = false;
            Description = 'Used for DropDown FieldGroup';
        }
        field(80004; "BA Ship-to Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Name';
            Editable = false;
            Description = 'Used for DropDown FieldGroup';
        }
    }

    fieldgroups
    {
        addlast(DropDown; "BA Posting Date", "BA Order No.", "BA Sell-to Customer No.", "BA Sell-to Customer Name", "BA Ship-to Name") { }
    }
}