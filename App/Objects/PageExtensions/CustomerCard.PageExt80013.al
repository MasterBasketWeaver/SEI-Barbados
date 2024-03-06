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
        addlast(Content)
        {
            group("BA Account & System Control")
            {
                Caption = 'Account & System Control';
                field("BA Blocked"; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("BA Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = all;
                }
                field("BA Salesperson/Country Mandatory"; Rec."Salesperson/Country Manadatory")
                {
                    ToolTip = 'Specifies the value of the Salesperson/Country Mandatory field.';
                    ApplicationArea = All;
                }
                field("BA SEI Service Center"; Rec."BA SEI Service Center")
                {
                    ApplicationArea = all;
                }
                field("BA Sell-to State Mandatory"; Rec."BA Sell-to State Mandatory")
                {
                    ApplicationArea = all;
                }
                field("BA Ship-to State Mandatory"; Rec."BA Ship-to State Mandatory")
                {
                    ApplicationArea = all;
                }
                field("BA FID No. Mandatory"; Rec."BA FID No. Mandatory")
                {
                    ApplicationArea = all;
                }
                field("BA Sell-to EORI No."; Rec."BA EORI No. Mandatory")
                {
                    ApplicationArea = all;
                }
            }
        }
        modify(Blocked)
        {
            ApplicationArea = all;
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            ApplicationArea = all;
            Visible = false;
        }
    }

    var
        [InDataSet]
        IsEditable: Boolean;
        CityText: Text[30];
        PostCode: Code[20];


    trigger OnAfterGetCurrRecord()
    begin
        CityText := Rec."City";
        PostCode := Rec."Post Code";
        IsEditable := CurrPage.Editable();
    end;
}