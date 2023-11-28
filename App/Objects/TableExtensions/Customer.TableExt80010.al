tableextension 80010 "BA Customer" extends Customer
{
    fields
    {
        field(80010; "BA Region"; Text[30])
        {
            Caption = 'Region';
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region"."BA Region" where(Code = field("Country/Region Code")));
            Editable = false;
        }
        field(80011; "BA County Fullname"; Text[50])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Print Full Name" = const(true), "Country/Region Code" = field("Country/Region Code"), Symbol = field(County)));
            Editable = false;
        }
        field(80012; "BA Province/State"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Province/State';
            TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Country/Region Code"));

            trigger OnValidate()
            begin
                Rec.Validate(County, "BA Province/State");
                Rec.CalcFields("BA County Fullname");
            end;
        }
        modify("Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                if "Country/Region Code" = '' then
                    "BA Region" := ''
                else
                    Rec.CalcFields("BA Region");
            end;
        }
    }
}