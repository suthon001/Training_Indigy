table 50101 "IDG Traning Line"
{
    Caption = 'IDG Traning Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
