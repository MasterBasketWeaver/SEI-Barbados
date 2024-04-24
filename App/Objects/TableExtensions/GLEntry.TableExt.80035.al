tableextension 80035 "BA G/L Entries" extends "G/L Entry"
{
    fields
    {
        field(80000; "BA Prov/State for Reports"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Prov/State for Reports';
            TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Country for Reports"));
            trigger OnValidate()
            begin
                Rec.CalcFields("BA Prov/State Name for Reports");
            end;
        }
        field(80001; "BA Prov/State Name for Reports"; Text[50])
        {
            Caption = 'Prov/State Name for Reports';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Country/Region Code" = field("Country for Reports"), Symbol = field("BA Prov/State for Reports")));
            Editable = false;
        }
        modify("Country for Reports")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Country for Reports" <> xRec."Country for Reports" then
                    Rec."BA Prov/State for Reports" := '';
                Rec.CalcFields("BA Prov/State Name for Reports");
            end;
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

    trigger OnInsert()
    begin
        Rec."BA Actual Posting DateTime" := CurrentDateTime();
    end;
}