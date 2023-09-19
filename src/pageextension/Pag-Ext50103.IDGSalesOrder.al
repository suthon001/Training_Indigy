pageextension 50103 "IDG Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Traning Dev"; Rec."Traning Dev")
            {
                ApplicationArea = all;
            }
        }
    }
}
