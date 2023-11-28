pageextension 80006 "BA Sales Quote" extends "Sales Quote"
{
    layout
    {
        modify("Order Date")
        {
            ApplicationArea = all;
            Editable = false;
        }
        modify("Shipment Date")
        {
            ApplicationArea = all;
            Visible = false;
            Editable = false;
            Enabled = false;
        }
        addafter("Document Date")
        {
            field("BA Quote Date"; Rec."BA Quote Date")
            {
                ApplicationArea = all;
            }
        }
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
        addfirst(Control72)
        {
            field("BA Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country';
            }
        }
    }
    actions
    {
        addlast(Action59)
        {
            action("BA Proforma Invoice")
            {
                ApplicationArea = all;
                Caption = 'Proforma Invoice';
                Image = ViewPostedOrder;

                trigger OnAction()
                var
                    DocPrint: Codeunit "Document-Print";
                begin
                    DocPrint.PrintProformaSalesInvoice(Rec);
                end;
            }
        }
    }
}