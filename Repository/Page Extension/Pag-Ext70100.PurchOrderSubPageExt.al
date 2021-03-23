pageextension 70100 "Purch. Order SubPage Ext" extends "Purchase Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field(TSItemNo; Rec."TS Item No.")
            {
                Caption = 'TS Item No.';
                ApplicationArea = All;
            }
            field(TSID; Rec."TS ID.")
            {
                Caption = 'TS ID.';
                ApplicationArea = All;
            }
            field(TSErrorMessage; Rec."TS Error Message")
            {
                Caption = 'TS Error Message';
                ApplicationArea = All;
            }
            field(VesselName; Rec."Vessel Name")
            {
                Caption = 'Vessel Name';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Item Tracking Lines")
        {
            action(AssignLotNos)
            {
                ApplicationArea = All;
                Caption = 'Assign Lot No''s';
                Image = Lot;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemRec: Record Item;
                    PurchaseLine: Record "Purchase Line";
                    ReservationEntry: Record "Reservation Entry";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    LotNo: Code[20];
                    ItemExistErr: Label 'Please Select Item No.';
                    ItemErr: Label 'Type Should be Item';
                    NothingtoCreateErr: Label 'Nothing to Create.';
                    LotNoExistErr: Label 'Lot Information already exist for Line %1';
                begin
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document Type", Rec."Document Type");
                    PurchaseLine.SetRange("Document No.", Rec."Document No.");
                    PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.FindSet() then begin
                        repeat
                            if PurchaseLine.Type <> PurchaseLine.Type::Item then
                                Error(ItemErr);

                            if PurchaseLine."No." = '' then
                                Error(ItemExistErr);

                            ReservationEntry.Reset();
                            ReservationEntry.SetRange("Source Type", 39);
                            ReservationEntry.SetRange("Source Subtype", 1);
                            ReservationEntry.SetRange("Source ID", PurchaseLine."Document No.");
                            ReservationEntry.SetRange("Source Ref. No.", PurchaseLine."Line No.");
                            ReservationEntry.SetRange("Item No.", PurchaseLine."No.");
                            if not ReservationEntry.FindFirst() then begin
                                ItemRec.Get(PurchaseLine."No.");
                                ItemRec.TestField("Lot Nos.");
                                clear(NoSeriesMgt);
                                LotNo := NoSeriesMgt.GetNextNo(ItemRec."Lot Nos.", Today, true);
                                Rec.CreateReservationEntry(PurchaseLine."No.", PurchaseLine."Location Code", PurchaseLine."Qty. to Receive (Base)", 39, 1, PurchaseLine.Description,
                                        PurchaseLine."Document No.", PurchaseLine."Line No.", PurchaseLine."Qty. per Unit of Measure", PurchaseLine."Qty. to Receive", LotNo, true, '', 2, 0D);
                            end;
                        Until PurchaseLine.Next() = 0;
                    end else
                        Error(NothingtoCreateErr);
                end;
            }
            action(AssignLotNo)
            {
                ApplicationArea = All;
                Caption = 'Assign Lot No.';
                Image = Lot;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemRec: Record Item;
                    PurchaseLine: Record "Purchase Line";
                    ReservationEntry: Record "Reservation Entry";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    LotNo: Code[20];
                    ItemExistErr: Label 'Please Select Item No.';
                    ItemErr: Label 'Type Should be Item';
                    NothingtoCreateErr: Label 'Nothing to Create.';
                    LotNoExistErr: Label 'Lot Information already exist for Line %1';
                begin
                    if Rec.Type <> Rec.Type::Item then
                        Error(ItemErr);

                    if Rec."No." = '' then
                        Error(ItemExistErr);


                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source Type", 39);
                    ReservationEntry.SetRange("Source Subtype", 1);
                    ReservationEntry.SetRange("Source ID", Rec."Document No.");
                    ReservationEntry.SetRange("Source Ref. No.", Rec."Line No.");
                    ReservationEntry.SetRange("Item No.", Rec."No.");
                    if not ReservationEntry.FindFirst() then begin
                        ItemRec.Get(Rec."No.");
                        ItemRec.TestField("Lot Nos.");
                        clear(NoSeriesMgt);
                        LotNo := NoSeriesMgt.GetNextNo(ItemRec."Lot Nos.", Today, true);
                        Rec.CreateReservationEntry(Rec."No.", Rec."Location Code", Rec."Qty. to Receive (Base)", 39, 1, Rec.Description,
                                Rec."Document No.", Rec."Line No.", Rec."Qty. per Unit of Measure", Rec."Qty. to Receive", LotNo, true, '', 2, 0D);
                    end else
                        Error(LotNoExistErr, Rec."Line No.");
                end;
            }

        }
    }


}