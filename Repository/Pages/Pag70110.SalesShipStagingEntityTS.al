page 70110 "Sales Ship Staging Entity TS"
{
    Caption = 'Sales Shipments Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Sales Shipments Staging TS";
    EntityName = 'salesShipments';
    EntitySetName = 'salesShipmentsTS';
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
                field(SalesOrderNo; Rec."Sales Order No.")
                {
                    Caption = 'Sales Order No.';
                    ApplicationArea = All;
                }
                field(ShipmentNo; Rec."Shipment No.")
                {
                    Caption = 'Shipment No.';
                    ApplicationArea = All;
                }
                field(ShipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
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
                field(QtyLength; Rec."Quantity (Length)")
                {
                    Caption = 'Quantity (Length)';
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