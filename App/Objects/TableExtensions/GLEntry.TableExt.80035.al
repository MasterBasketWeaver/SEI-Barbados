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
                Rec.CalcFields("BA Prov/State for Reports");
            end;
        }
        field(80001; "BA Prov/State Name for Reports"; Text[50])
        {
            Caption = 'Prov/State Name for Reports';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Country/Region Code" = field("Country for Reports")));
            Editable = false;
        }
    }
}