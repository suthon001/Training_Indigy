tableextension 50104 "IDG Item Ledger Entry" extends "Item Ledger Entry"
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
