page 70111 "Sales Ship Staging List TS"
{
    Caption = 'Sales Shipments Staging List - TS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Sales Shipments Staging TS";
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
            action("Update Sales Shipments")
            {
                Caption = 'Update Sales Shipments';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.UpdateSalesShipment();
                end;
            }
        }
    }
}