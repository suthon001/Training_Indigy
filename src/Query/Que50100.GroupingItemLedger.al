query 50100 "Grouping ItemLedger"
{
    Caption = 'Grouping ItemLedger';
    QueryType = Normal;

    elements
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(Posting_DateYear; "Posting Date")
            {
                Method = Year;
            }
            column(ItemNo; "Item No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(Quantity; Quantity)
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
