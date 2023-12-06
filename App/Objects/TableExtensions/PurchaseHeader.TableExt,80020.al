tableextension 80020 "BA Purchase Header" extends "Purchase Header"
{
    fields
    {
        modify("Pay-to Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Pay-to County Fullname");
            end;
        }
        modify("Buy-from Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Buy-from County Fullname");
            end;
        }
        modify("Ship-to Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Ship-to County Fullname");
            end;
        }
        modify("Pay-to County")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Pay-to County Fullname");
            end;
        }
        modify("Buy-from County")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Buy-from County Fullname");
            end;
        }
        modify("Ship-to County")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Ship-to County Fullname");
            end;
        }
        field(80011; "BA Pay-to County Fullname"; Text[50])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Print Full Name" = const(true), "Country/Region Code" = field("Pay-to Country/Region Code"), Symbol = field("Pay-to County")));
            Editable = false;
        }
        field(80012; "BA Buy-from County Fullname"; Text[50])
        {
            Caption = 'Province/State Fullname';
            FieldClass = FlowField;
            CalcFormula = lookup("BA Province/State".Name where("Print Full Name" = const(true), "Country/Region Code" = field("Buy-from Country/Region Code"), Symbol = field("Buy-from County")));
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