pageextension 80006 "BA Customer Card" extends "Customer Card"
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
    }
}