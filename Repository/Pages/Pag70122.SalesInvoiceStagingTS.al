page 70122 "Sales Invoice Staging TS"
{
    Caption = 'Sales Invoice Staging List - TS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Sales Invoice TS";
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field(CustomerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                }
                field(CustomerPO; Rec."Customer PO No.")
                {
                    Caption = 'Customer PO No.';
                    ApplicationArea = All;
                }
                field(InvoiceAmount; Rec."Amount Including VAT")
                {
                    Caption = 'Invoice Amount';
                    ApplicationArea = All;
                }
                field(InvoiceClosureDate; Rec."Invoice Closure Date")
                {
                    Caption = 'Invoice Closure Date';
                    ApplicationArea = All;
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ApplicationArea = All;
                }
                field(InvoiceDate; Rec."Invoice Date")
                {
                    Caption = 'Invoice Date';
                    ApplicationArea = All;
                }
                field(DueDate; Rec."Due Date")
                {
                    Caption = 'Due Date';
                    ApplicationArea = All;
                }
                field(SalesOrderNo; Rec."Sales Order No.")
                {
                    Caption = 'Sales Order No.';
                    ApplicationArea = All;
                }
                field(SalesInvoiceNo; Rec."Sales Invoice No.")
                {
                    Caption = 'Sales Invoice No.';
                    ApplicationArea = All;
                }
                field(MRNo; Rec."MR No.")
                {
                    Caption = 'MR No.';
                    ApplicationArea = All;
                }
                field(CreatedBy; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(CreatedOn; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field(TSSyncStatus; Rec."TS Sync Status")
                {
                    ApplicationArea = All;
                }
                field(TSErrorMessage; Rec."TS Error Message")
                {
                    ApplicationArea = All;
                }
                field(TSSyncedOn; Rec."TS Synced On")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Sales Invoice in TubeStream")
            {
                Caption = 'Update Sales Invoice in TubeStream';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataToTS: Page "Test API Staging TS";
                begin
                    InsertDataToTS.UpdateSalesInvoicetoTS();
                end;
            }
        }
    }
}