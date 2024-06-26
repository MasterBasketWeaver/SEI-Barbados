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
        field(80010; "BA Quote Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Date';
            Editable = false;
        }
        field(80011; "BA Sell-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80012; "BA Bill-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80013; "BA Ship-to County Fullname"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State Fullname';
            Editable = false;
        }
        field(80021; "BA EORI No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'EORI No.';
            Editable = false;
        }
        field(80022; "BA Ship-to EORI No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to EORI No.';
            Editable = false;
        }
        field(80100; "BA Actual Posting DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Posting DateTime';
            Editable = false;
        }
    }

    keys
    {
        key("BA Actual Posting"; "BA Actual Posting DateTime") { }
    }

    fieldgroups
    {
        addlast(DropDown; "BA Posting Date", "BA Order No.", "BA Sell-to Customer No.", "BA Sell-to Customer Name", "BA Ship-to Name") { }
    }


    trigger OnInsert()
    begin
        Rec."BA Actual Posting DateTime" := CurrentDateTime();
    end;
}