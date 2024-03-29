table 75013 "BA Province/State"
{
    DataClassification = CustomerContent;
    Caption = 'Province/State';
    DrillDownPageId = "BA Province/State List";
    LookupPageId = "BA Province/State List";

    fields
    {
        field(1; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Country/Region".Code;
        }
        field(2; "Symbol"; Code[30])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Country/Region Name"; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Name where(Code = field("Country/Region Code")));
        }
        field(5; "Print Full Name"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Install: Codeunit "BA Install Data";
            begin
                if "Print Full Name" then
                    Install.PopulateProvinceStateFields(Symbol);
            end;
        }
    }

    keys
    {
        key(K1; "Country/Region Code", Symbol)
        {
            Clustered = true;
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
        if UserId() <> 'SYSTEM' then
            if not UserSetup.Get(UserId()) or not UserSetup."BA Allow Changing Counties" then
                Error(InvalidPermissionError);
    end;

    var
        InvalidPermissionError: Label 'You do not have permission to make this change.';
}