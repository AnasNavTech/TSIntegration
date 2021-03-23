page 70107 "Purch. Rcpts Staging List TS"
{
    Caption = 'Purchase Receipts Staging List TS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Receipts TS";
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
                field(PurchaseOrderNo; Rec."Purchase Order No.")
                {
                    Caption = 'Purchase Order No.';
                    ApplicationArea = All;
                }
                field(PurchaseReceiptNo; Rec."Purchase Receipt No.")
                {
                    Caption = 'Purchase Receipt No.';
                    ApplicationArea = All;
                }
                field(TSItemNo; Rec."TS Item No.")
                {
                    Caption = 'TS Item No.';
                    ApplicationArea = All;
                }
                field(LotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                    ApplicationArea = All;
                }
                field(QtyReceived; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
                    ApplicationArea = All;
                }
                field(QtyGood; Rec."Quantity Good")
                {
                    Caption = 'Quantity Good';
                    ApplicationArea = All;
                }
                field(QtyDamaged; Rec."Quantity Damaged")
                {
                    Caption = 'Quantity Damaged';
                    ApplicationArea = All;
                }
                field(QtyRejected; Rec."Quantity Rejected")
                {
                    Caption = 'Quantity Rejected';
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
            action("Update Purchase Receipts")
            {
                Caption = 'Update Purchase Receipts';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.UpdatePurchaseReceiptsStaging();
                end;
            }
        }
    }
}