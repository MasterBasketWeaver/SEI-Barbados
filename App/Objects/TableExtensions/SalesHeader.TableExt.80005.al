tableextension 80005 "BA Sales Header" extends "Sales Header"
{
    fields
    {
        field(80011; "BA Sell-to County Fullname"; Text[50])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Print Full Name" = const(true), "Country/Region Code" = field("Sell-to Country/Region Code"), Symbol = field("Sell-to County")));
            Editable = false;
        }
        field(80012; "BA Bill-to County Fullname"; Text[50])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Print Full Name" = const(true), "Country/Region Code" = field("Bill-to Country/Region Code"), Symbol = field("Bill-to County")));
            Editable = false;
        }
        field(80013; "BA Ship-to County Fullname"; Text[50])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Print Full Name" = const(true), "Country/Region Code" = field("Ship-to Country/Region Code"), Symbol = field("Ship-to County")));
            Editable = false;
        }
    }
}