tableextension 80007 "BA Country/Region" extends "Country/Region"
{
    fields
    {
        field(80000; "BA Region"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Region';
            TableRelation = "BA Region".Name;
        }
        field(80030; "BA Sell-to State Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to State Mandatory';
        }
        field(80031; "BA Ship-to State Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to State Mandatory';
        }
    }

    trigger OnDelete()
    begin
        CheckIfCanMakeChanges();
    end;

    trigger OnInsert()
    begin
        CheckIfCanMakeChanges();
    end;

    trigger OnRename()
    begin
        CheckIfCanMakeChanges();
    end;

    trigger OnModify()
    begin
        CheckIfCanMakeChanges();
    end;

    procedure CheckIfCanMakeChanges()
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) or not UserSetup."BA Allow Changing Regions" then
            Error(InvalidPermissionError);
    end;

    var
        InvalidPermissionError: Label 'You do not have permission to make this change.';
}