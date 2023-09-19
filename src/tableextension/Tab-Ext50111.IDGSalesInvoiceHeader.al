tableextension 50111 "IDG Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(99999; "Posted By"; code[50])
        {
            Caption = 'Posted By';
            DataClassification = CustomerContent;
        }
    }
}
