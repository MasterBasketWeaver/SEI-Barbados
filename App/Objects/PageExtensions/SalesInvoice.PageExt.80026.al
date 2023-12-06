pageextension 80026 "BA Sales Invoice" extends "Sales Invoice"
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
        modify("Sell-to County")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Sell-to County")
        {
            field("BA Sell-to County"; SellToState)
            {
                ApplicationArea = all;
                Caption = 'Sell-to County';
                CaptionClass = '5,1,' + Rec."Sell-to Country/Region Code";
                TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Sell-to Country/Region Code"));
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Sell-to County" := SellToState;
                    Rec.CalcFields("BA Sell-to County Fullname");
                end;
            }
            field("BA Sell-to County Fullname"; Rec."BA Sell-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Ship-to County")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Ship-to County")
        {
            field("BA Ship-to County"; ShipToState)
            {
                ApplicationArea = all;
                Caption = 'Ship-to County';
                CaptionClass = '5,1,' + Rec."Ship-to Country/Region Code";
                TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Ship-to Country/Region Code"));
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Ship-to County" := ShipToState;
                    Rec.CalcFields("BA Ship-to County Fullname");
                end;
            }
            field("BA Ship-to County Fullname"; Rec."BA Ship-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Bill-to County")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
            Caption = 'herp derp';
        }
        addafter("Bill-to County")
        {
            field("BA Bill-to County"; BillToState)
            {
                ApplicationArea = all;
                Caption = 'Bill-to County';
                CaptionClass = '5,1,' + Rec."Bill-to Country/Region Code";
                TableRelation = "BA Province/State".Symbol where("Country/Region Code" = field("Bill-to Country/Region Code"));
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Bill-to County" := BillToState;
                    Rec.CalcFields("BA Bill-to County Fullname");
                end;
            }
            field("BA Bill-to County Fullname"; Rec."BA Bill-to County Fullname")
            {
                ApplicationArea = all;
            }
        }
        modify("Bill-to City")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Bill-to City")
        {
            field("BA Bill-to City"; BillToCity)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Bill-to City" := BillToCity;
                end;
            }
        }
        modify("Ship-to City")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Ship-to City")
        {
            field("BA Ship-to City"; ShipToCity)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Ship-to City" := ShipToCity;
                end;
            }
        }
        modify("Sell-to City")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Sell-to City")
        {
            field("BA Sell-to City"; SellToCity)
            {
                ApplicationArea = all;
                Caption = 'City';
                Editable = IsEditable;

                trigger OnValidate()
                begin
                    Rec."Sell-to City" := SellToCity;
                end;
            }
        }
    }

    var
        BillToState: Code[30];
        ShipToState: Code[30];
        SellToState: Code[30];
        BillToCity: Text[30];
        ShipToCity: Text[30];
        SellToCity: Text[30];
        [InDataSet]
        IsEditable: boolean;

    trigger OnAfterGetCurrRecord()
    begin
        BillToCity := Rec."Bill-to City";
        SellToCity := Rec."Sell-to City";
        ShipToCity := Rec."Ship-to City";
        BillToState := Rec."Bill-to County";
        SellToState := Rec."Sell-to County";
        ShipToState := Rec."Ship-to County";
        IsEditable := CurrPage.Editable();
    end;
}