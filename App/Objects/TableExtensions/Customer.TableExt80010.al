tableextension 80010 "BA Customer" extends Customer
{
    fields
    {
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

        field(80020; "BA SEI Service Center"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SEI Service Center';
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
        field(80032; "BA FID No. Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FID No. Mandatory';
        }
        field(80033; "BA EORI No. Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'EORI No. Mandatory';
        }
        field(80034; "BA COC Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cert. of Conformity (COC)  Mandatory';
        }
        field(80035; "BA EORI No."; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'EORI No.';
        }
    }
}