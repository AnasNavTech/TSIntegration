page 70106 "Purch. Rcpts Staging Entity TS"
{
    Caption = 'Purchase Receipts Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Purchase Receipts TS";
    EntityName = 'PurchaseReceipts';
    EntitySetName = 'purchaseReceiptsTS';
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