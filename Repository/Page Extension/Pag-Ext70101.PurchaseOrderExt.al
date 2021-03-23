pageextension 70101 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field(InternalReqNo; Rec."Internal Request No.")
            {
                Caption = 'Internal Request No.';
                ApplicationArea = All;
                Editable = false;
            }
            field(MillCode; Rec."Mill Code")
            {
                Caption = 'Mill Code';
                ApplicationArea = All;
            }
            field(MillName; Rec."Mill Name")
            {
                Caption = 'Mill Name';
                ApplicationArea = All;
            }
            field(SendtoTS; Rec."Send to TS")
            {
                Caption = 'Send to TS';
                ApplicationArea = All;
            }
            field(TSErrorMessage; Rec."TS Error Message")
            {
                Caption = 'TS Error Message';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Create Inventor&y Put-away/Pick")
        {
            action(MillMaster)
            {
                ApplicationArea = All;
                Caption = 'Mill Master';
                Image = MachineCenter;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Mill Master List";
            }
        }
        modify(Release)
        {
            trigger OnAfterAction()
            begin
                InsertDatatoPurchaseOrderStaging();
            end;
        }
    }


    var
        myInt: Integer;

    Procedure InsertDatatoPurchaseOrderStaging()
    var
        PurchaseLine: Record "Purchase Line";
        ReservationEntry: Record "Reservation Entry";
        PurchaseOrderStaging: Record "Purchase Order TS";
        Customer: Record Customer;
        EntryNo: Integer;
        PurchaseAlreadyExistMsg: Label 'The Purchase Line already Synced. Purchase Order No : %1  Purchase Line No : %2';
        LotNoExistErr: Label 'Lot Information does not Exist for Line %1';
    begin
        Rec.TestField("Vendor Invoice No.");

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."No.");
        if PurchaseLine.FindSet() then
            repeat
                PurchaseLine.TestField("Expected Receipt Date");

                if PurchaseLine.Type = PurchaseLine.Type::Item then begin
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source Type", 39);
                    ReservationEntry.SetRange("Source Subtype", 1);
                    ReservationEntry.SetRange("Source ID", PurchaseLine."Document No.");
                    ReservationEntry.SetRange("Source Ref. No.", PurchaseLine."Line No.");
                    ReservationEntry.SetRange("Item No.", PurchaseLine."No.");
                    if not ReservationEntry.FindFirst() then
                        Error(LotNoExistErr, PurchaseLine."Line No.");
                end;

                PurchaseOrderStaging.Reset;
                PurchaseOrderStaging.SetRange("Purchase Order No.", PurchaseLine."Document No.");
                PurchaseOrderStaging.SetRange("Purchase Line No.", PurchaseLine."Line No.");
                if PurchaseOrderStaging.FindFirst() then begin
                    if PurchaseOrderStaging."TS Sync Status" = PurchaseOrderStaging."TS Sync Status"::"Sync Complete" then
                        Error(PurchaseAlreadyExistMsg, PurchaseLine."Document No.", PurchaseLine."Line No.")
                    else
                        PurchaseOrderStaging.Delete();
                end;
                PurchaseOrderStaging.Reset();
                if PurchaseOrderStaging.FindLast() then
                    EntryNo := PurchaseOrderStaging."Entry No." + 1
                Else
                    EntryNo := 1;
                PurchaseOrderStaging.Init();
                PurchaseOrderStaging."Entry No." := EntryNo;
                PurchaseOrderStaging."Purchase Order No." := Rec."No.";
                PurchaseOrderStaging."Customer PO No." := Rec."Vendor Invoice No.";
                PurchaseOrderStaging."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
                PurchaseOrderStaging."Mill Code" := Rec."Mill Code";
                PurchaseOrderStaging."Mill Name" := Rec."Mill Name";
                PurchaseOrderStaging."Book Value" := PurchaseLine.Quantity;
                PurchaseOrderStaging."Book Value Mt" := PurchaseLine.Amount;
                PurchaseOrderStaging."TS Item No." := PurchaseLine."TS Item No.";
                PurchaseOrderStaging."Customer Account No." := Rec."Sell-to Customer No.";
                PurchaseOrderStaging."Created By" := UserId;
                PurchaseOrderStaging."Created On" := Today;
                PurchaseOrderStaging.Destination := PurchaseLine."Location Code";
                PurchaseOrderStaging.Unit := PurchaseLine."Unit of Measure";
                PurchaseOrderStaging.Price := PurchaseLine."Unit Price (LCY)";
                PurchaseOrderStaging.Quantity := PurchaseLine.Quantity;
                PurchaseOrderStaging."Vessel Name" := PurchaseLine."Vessel Name";
                PurchaseOrderStaging."Purchase Line No." := PurchaseLine."Line No.";
                PurchaseOrderStaging."TS Sync Status" := PurchaseOrderStaging."TS Sync Status"::"Waiting for Sync";
                PurchaseOrderStaging.Insert();
            Until PurchaseLine.Next() = 0;
    end;
}