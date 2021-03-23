page 70129 "SR Order Staging List TS"
{
    Caption = 'Sales Return Order Staging List TS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Ret. Order Staging TS";
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
                field(CallOffNumber; Rec."Call Off Number")
                {
                    Caption = 'Call Off Number';
                    ApplicationArea = All;
                }
                field(CustomerCode; Rec."Customer Code")
                {
                    Caption = 'Customer Code';
                    ApplicationArea = All;
                }
                field(ReturnDate; Rec."Return Date")
                {
                    Caption = 'Return Date';
                    ApplicationArea = All;
                }
                field(ItemNumbers; Rec."Item Numbers")
                {
                    Caption = 'Item Numbers';
                    ApplicationArea = All;
                }
                field(LotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
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
                field(RigNumber; Rec."Rig Number")
                {
                    Caption = 'Rig Number';
                    ApplicationArea = All;
                }
                field(WellNumber; Rec."Well Number")
                {
                    Caption = 'Well Number';
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
            action("Update Sales Return Orders")
            {
                Caption = 'Create Sales Return Orders';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataFromTS: Codeunit "Insert Data From TS";
                begin
                    InsertDataFromTS.CreateSalesReturnOrder();
                end;
            }
        }
    }
}