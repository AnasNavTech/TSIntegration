page 70116 "Inventory Adjust. Entity TS"
{
    Caption = 'Inventory Adjustments Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Inventory Adjust. Staging TS";
    EntityName = 'inventoryAdjustments';
    EntitySetName = 'inventoryAdjustmentsTS';
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
                field(DocumentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field(LocationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ApplicationArea = All;
                }
                field(EntryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                    ApplicationArea = All;
                }
                field(PostingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
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
                field(UnitofMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                    ApplicationArea = All;
                }
                field(ReasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code';
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