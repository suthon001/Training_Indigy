xmlport 50100 "Export Customer"
{
    Caption = 'Export Customer';
    Direction = Export;
    // Encoding = UTF8;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = '<TAB>';
    FieldDelimiter = '<None>';
    UseRequestPage = true;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Customer; Customer)
            {

                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(Name; Customer.Name)
                {
                }
                fieldelement(SearchName; Customer."Search Name")
                {
                }
                fieldelement(Name2; Customer."Name 2")
                {
                }
                fieldelement(Address; Customer.Address)
                {
                }
                fieldelement(Address2; Customer."Address 2")
                {
                }
                fieldelement(City; Customer.City)
                {
                }
                fieldelement(Contact; Customer.Contact)
                {
                }
                fieldelement(PhoneNo; Customer."Phone No.")
                {
                }
                fieldelement(TelexNo; Customer."Telex No.")
                {
                }
                fieldelement(DocumentSendingProfile; Customer."Document Sending Profile")
                {
                }
                fieldelement(ShiptoCode; Customer."Ship-to Code")
                {
                }
                fieldelement(OurAccountNo; Customer."Our Account No.")
                {
                }
                fieldelement(TerritoryCode; Customer."Territory Code")
                {
                }
                fieldelement(GlobalDimension1Code; Customer."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDimension2Code; Customer."Global Dimension 2 Code")
                {
                }
                fieldelement(ChainName; Customer."Chain Name")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
