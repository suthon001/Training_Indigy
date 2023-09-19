tableextension 50103 "IDG Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50100; "Traning Dev"; Date)
        {
            Caption = 'Training Dev.';
            DataClassification = CustomerContent;
        }
        field(99999; "Posted By"; code[50])
        {
            Caption = 'Posted By';
            DataClassification = CustomerContent;
        }
    }
}
