page 70128 "SR Order Staging Entity TS"
{
    Caption = 'Sales Return Order Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Sales Ret. Order Staging TS";
    EntityName = 'salesreturnorders';
    EntitySetName = 'salesreturnordersTS';
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