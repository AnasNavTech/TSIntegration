page 70100 "Customer Staging Entity TS"
{
    Caption = 'Customer Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Customer Staging TS";
    EntityName = 'Customers';
    EntitySetName = 'customersTS';
    ODataKeyFields = ID;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field(No; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field(Name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                    ApplicationArea = All;
                }
                field(Address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Caption = 'City';
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    Caption = 'Country';
                    ApplicationArea = All;
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    Caption = 'Email';
                    ApplicationArea = All;
                }
                field(VATRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';
                    ApplicationArea = All;
                }
                field(CreditLimit; Rec."Credit Limit")
                {
                    Caption = 'Credit Limit';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        myInt: Integer;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Insert(true);
        exit(false);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.Delete(true);
    end;
}