page 70112 "Trans. Order Staging Entity TS"
{
    Caption = 'Transfer Order Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Transfer Order Staging TS";
    EntityName = 'transferOrder';
    EntitySetName = 'transferOrdersTS';
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
                field(TransferOrderNo; Rec."Transfer Order No.")
                {
                    Caption = 'Transfer Order No.';
                    ApplicationArea = All;
                }
                field(FromLocationCode; Rec."From Location Code")
                {
                    Caption = 'From Location Code';
                    ApplicationArea = All;
                }
                field(ToLocationCode; Rec."To Location Code")
                {
                    Caption = 'To Location Code';
                    ApplicationArea = All;
                }
                field(TransferDate; Rec."Transfer Date")
                {
                    Caption = 'Transfer Date';
                    ApplicationArea = All;
                }
                field(TSItemNo; Rec."TS Item No.")
                {
                    Caption = 'TS Item No.';
                    ApplicationArea = All;
                }
                field(ItemLotNo; Rec."Item Lot No.")
                {
                    Caption = 'Item Lot No.';
                    ApplicationArea = All;
                }
                field(Qty; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field(QuantityShipped; Rec."Quantity Shipped")
                {
                    Caption = 'Quantity Shipped';
                    ApplicationArea = All;
                }
                field(QuantityReceived; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
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