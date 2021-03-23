page 70121 "Purchase Order Staging TS"
{
    Caption = 'Purchase Order Staging List - TS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Order TS";
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
                field(Allowance; Rec.Allowance)
                {
                    Caption = 'Allowance';
                    ApplicationArea = All;
                }
                field(BookValue; Rec."Book Value")
                {
                    Caption = 'Book Value';
                    ApplicationArea = All;
                }
                field(BookValueMt; Rec."Book Value Mt")
                {
                    Caption = 'Book Value Mt';
                    ApplicationArea = All;
                }
                field(CustomerAccountNo; Rec."Customer Account No.")
                {
                    Caption = 'Customer Account No.';
                    ApplicationArea = All;
                }
                field(CustomerPONo; Rec."Customer PO No.")
                {
                    Caption = 'Customer PO No.';
                    ApplicationArea = All;
                }
                field(Destination; Rec.Destination)
                {
                    Caption = 'Destination';
                    ApplicationArea = All;
                }
                field(ExpectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
                    ApplicationArea = All;
                }
                field(TSItemNo; Rec."TS Item No.")
                {
                    Caption = 'TS Item No.';
                    ApplicationArea = All;
                }
                field(MillName; Rec."Mill Name")
                {
                    Caption = 'Mill Name';
                    ApplicationArea = All;
                }
                field(MillCode; Rec."Mill Code")
                {
                    Caption = 'Mill Code';
                    ApplicationArea = All;
                }
                field(PurchaseOrderNo; Rec."Purchase Order No.")
                {
                    Caption = 'Purchase Order No.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    Caption = 'Unit';
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                }
                field(VesselName; Rec."Vessel Name")
                {
                    Caption = 'Vessel Name';
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
            action("Create Purchase Order in TubeStream")
            {
                Caption = 'Create Purchase Order in TubeStream';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataToTS: Page "Test API Staging TS";
                begin
                    InsertDataToTS.PushPurchaseOrdertoTS();
                end;
            }
        }
    }
}