pageextension 80008 "BA Sales Return Order" extends "Sales Return Order"
{
    layout
    {
        modify("Sell-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst("Sell-to")
        {
            field("BA Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify("Bill-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addbefore("Bill-to Name")
        {
            field("BA Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addbefore("Ship-to Name")
        {
            field("BA Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        addafter("Sell-to County")
        {
            field("BA Sell-to County Fullname"; Rec."BA Sell-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Sell-to County")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Sell-to County Fullname");
            end;
        }
        addafter("Ship-to County")
        {
            field("BA Ship-to County Fullname"; Rec."BA Ship-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Ship-to County")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Ship-to County Fullname");
            end;
        }
        addafter("Bill-to County")
        {
            field("BA Bill-to County Fullname"; Rec."BA Bill-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Bill-to County")
        {
            trigger OnAfterValidate()
            begin
                Rec.CalcFields("BA Bill-to County Fullname");
            end;
        }
    }
}