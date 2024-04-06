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

            // trigger OnValidate()
            // var
            //     Customer: Record Customer;
            // begin
            //     Customer.SetRange("Country/Region Code", Rec.Code);
            //     Customer.ModifyAll("BA Sell-to State Mandatory", Rec."BA Sell-to State Mandatory");
            // end;
        }
        field(80031; "BA Ship-to State Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to State Mandatory';

            // trigger OnValidate()
            // var
            //     Customer: Record Customer;
            // begin
            //     Customer.SetRange("Country/Region Code", Rec.Code);
            //     Customer.ModifyAll("BA Ship-to State Mandatory", Rec."BA Ship-to State Mandatory");
            // end;
        }
        field(80032; "BA FID No. Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FID No. Mandatory';

            // trigger OnValidate()
            // var
            //     Customer: Record Customer;
            // begin
            //     Customer.SetRange("Country/Region Code", Rec.Code);
            //     Customer.ModifyAll("BA FID No. Mandatory", Rec."BA FID No. Mandatory");
            // end;
        }
        field(80033; "BA EORI No. Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'EORI No. Mandatory';

            // trigger OnValidate()
            // var
            //     Customer: Record Customer;
            // begin
            //     Customer.SetRange("Country/Region Code", Rec.Code);
            //     Customer.ModifyAll("BA EORI No. Mandatory", Rec."BA EORI No. Mandatory");
            // end;
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