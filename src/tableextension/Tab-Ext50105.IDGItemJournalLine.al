tableextension 50105 "IDG Item Journal Line" extends "Item Journal Line"
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
