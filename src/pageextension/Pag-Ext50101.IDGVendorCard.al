pageextension 50101 "IDG Vendor Card" extends "Vendor Card"
{
    layout
    {
        addafter(Name)
        {
            field("IDG Customer No."; Rec."IDG Customer No.")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;

            }
            field("Full Name"; Rec."Full Name")
            {
                ApplicationArea = all;
            }

        }
        addfirst(General)
        {
            field("IDG Customer Name"; Rec."IDG Customer Name")
            {
                ApplicationArea = all;
            }
            field("Purchase Amount"; Rec."Purchase Amount")
            {
                ApplicationArea = all;
            }
        }
        moveafter(Name; "Search Name", "Home Page")
        modify(Name)
        {

            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }
        modify("Name 2")
        {
            Visible = true;
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

    }
    actions
    {

    }
}
