tableextension 50102 "IDG Sales Cue" extends "Sales Cue"
{
    fields
    {
        field(50100; "Sales Order - Release"; Integer)
        {
            Caption = 'Sales Order - Release';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter(Released)));
        }
    }
}
