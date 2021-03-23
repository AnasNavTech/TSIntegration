page 70101 "Customer Staging List TS"
{
    Caption = 'Customer Staging List TS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer Staging TS";
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EntryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
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
                field("Entry Date and Time"; Rec."Entry Date and Time")
                {
                    Caption = 'Entry Date and Time';
                    ApplicationArea = All;
                }
                field("Processing Date and Time"; Rec."Processing Date and Time")
                {
                    Caption = 'Processing Date and Time';
                    ApplicationArea = All;
                }
                field("Integration Status"; Rec."Integration Status")
                {
                    Caption = 'Integration Status';
                    ApplicationArea = All;
                }
                field("Retry Count"; Rec."Retry Count")
                {
                    Caption = 'Retry Count';
                    ApplicationArea = All;
                }
                field("Processing Remarks"; Rec."Processing Remarks")
                {
                    Caption = 'Processing Remarks';
                    ApplicationArea = All;
                }
                field("Error Remarks"; Rec."Error Remarks")
                {
                    Caption = 'Error Remarks';
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Process Customer")
            {
                Caption = 'Insert/Update Customer';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.InsertCustomerStaging();
                end;
            }
        }
    }
}