tableextension 50101 "IDG Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "Traning Dev"; Date)
        {
            Caption = 'Training Dev.';
            DataClassification = CustomerContent;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                if rec."Posting Date" <> xRec."Posting Date" then begin
                    Message('%1 %2', xRec."Posting Date", rec."Posting Date");
                end;
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            begin
                if rec."Posting Date" <> xRec."Posting Date" then begin
                    Message('%1 %2', xRec."Posting Date", rec."Posting Date");
                end;
            end;
        }
    }
}
