pageextension 80007 "BA Sales Order" extends "Sales Order"
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
                Editable = false;
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
                Editable = false;
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
                Editable = false;
            }
        }
        addafter("Sell-to County")
        {
            field("BA Sell-to County Fullname"; Rec."BA Sell-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        addafter("Ship-to County")
        {
            field("BA Ship-to County Fullname"; Rec."BA Ship-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to County")
        {
            field("BA Bill-to County Fullname"; Rec."BA Bill-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
    }
}