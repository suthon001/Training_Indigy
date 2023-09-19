pageextension 50104 "IDG Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Traning Dev"; Rec."Traning Dev")
            {
                ApplicationArea = all;
            }
            field("Posted By"; Rec."Posted By")
            {
                ApplicationArea = all;
            }
        }
    }
}
