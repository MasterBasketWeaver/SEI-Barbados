pageextension 80013 "BA Customer Card" extends "Customer Card"
{
    layout
    {
        modify("IC Partner Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Responsibility Center")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Service Zone Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("CFDI Purpose")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("CFDI Relation")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify(Reserve)
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Shipping Time")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Customized Calendar")
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Post Code")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Post Code")
        {
            field("BA Post Code"; PostCode)
            {
                ApplicationArea = all;
                Editable = IsEditable;
                Caption = 'Zip Code';

                trigger OnValidate()
                begin
                    Rec."Post Code" := PostCode;
                end;
            }
            field("BA Region"; Rec."BA Region")
            {
                ApplicationArea = all;
            }
        }
        modify(City)
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("City")
        {
            field("BA City"; City)
            {
                ApplicationArea = all;
                Editable = IsEditable;
                Caption = 'City';

                trigger OnValidate()
                begin
                    Rec."City" := City;
                end;
            }
        }
        addfirst(AddressDetails)
        {
            field("BA Country/Region Code"; Rec."Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
        modify(County)
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter(County)
        {
            field("BA Province/State"; Rec."BA Province/State")
            {
                ApplicationArea = all;
            }
            field("BA County Fullname"; Rec."BA County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Country/Region Code")
        {
            ApplicationArea = all;
            Visible = false;
            Enabled = false;
            Editable = false;
        }
        addafter("Service Zone Code")
        {
            field("BA SEI Service Center"; Rec."BA SEI Service Center")
            {
                ApplicationArea = all;
            }
        }
    }

    var
        [InDataSet]
        IsEditable: Boolean;
        City: Text[30];
        PostCode: Code[20];


    trigger OnAfterGetCurrRecord()
    begin
        City := Rec."City";
        PostCode := Rec."Post Code";
        IsEditable := CurrPage.Editable();
    end;
}