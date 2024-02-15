pageextension 80018 "BA Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        modify("Buy-from Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst("Buy-from")
        {
            field("BA Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
                Editable = false;
            }
        }
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
        }
        addfirst("Pay-to")
        {
            field("BA Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
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
        addfirst("Ship-to")
        {
            field("BA Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
                Editable = false;
            }
        }
        addafter("Pay-to County")
        {
            field("BA Sell-to County Fullname"; Rec."BA Pay-to County Fullname")
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
        addafter("Buy-from County")
        {
            field("BA Bill-to County Fullname"; Rec."BA Buy-from County Fullname")
            {
                ApplicationArea = all;
            }
        }
    }
}