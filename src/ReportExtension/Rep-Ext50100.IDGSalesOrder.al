reportextension 50100 "IDG Sales Order" extends "TPP Sales Order"
{
    dataset
    {
        add("Sales Header")
        {
            column(Business_group_Code; "Business group Code") { }
        }
        add("Sales Line")
        {
            column(Line_Discount__; "Line Discount %") { }
        }
    }
}
