page 70123 "Invoice Closure Staging TS"
{
    Caption = 'Invoice Closure Staging List - TS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Invoice Closure TS";
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
                field(InvoiceClosureDate; Rec."Invoice Closure Date")
                {
                    Caption = 'Invoice Closure Date';
                    ApplicationArea = All;
                }
                field(SalesInvoiceNo; Rec."Sales Invoice No.")
                {
                    Caption = 'Sales Invoice No.';
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
}