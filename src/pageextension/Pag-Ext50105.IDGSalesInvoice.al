pageextension 50105 "IDG Sales Invoice" extends "Sales Invoice"
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
