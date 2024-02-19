pageextension 80014 "BA Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("BA Created At"; Rec."BA Created At")
            {
                ApplicationArea = all;
            }
            field("BA Created By"; Rec."BA Created By")
            {
                ApplicationArea = all;
            }
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
            field("BA City"; CityText)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec.City := CityText
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
    }

    var
        [InDataSet]
        IsEditable: boolean;
        CityText: Text[30];
        PostCode: Code[20];


    trigger OnAfterGetCurrRecord()
    begin
        CityText := Rec."City";
        PostCode := Rec."Post Code";
        IsEditable := CurrPage.Editable();
    end;
}