tableextension 70106 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                Rec."Expected Receipt Date" := 0D;
            end;
        }
        field(70100; "TS ID."; text[50])
        {
            Caption = 'TS ID.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70101; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70102; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70103; "Internal Request No."; Code[20])
        {
            Caption = 'Internal Request No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Internal Request No." where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(70104; "Vessel Name"; Text[25])
        {
            Caption = 'Vessel Name';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;

    procedure CreateReservationEntry(ItemNo: Code[20]; LocationCode: Code[10]; QtytoReceiveBase: Decimal; SourceType: Integer; SubType: Integer;
            Desc: Text; DocumentNo: code[20]; LineNo: Integer; QtyPerUnit: decimal; QtytoReceive: Decimal; NewLotNo: Code[20]; Pos: Boolean; BatchName: Code[10]; ReservationStatus: Integer; PostingDate: Date)
    var
        ReservationEntry: Record "Reservation Entry";
        ReserveEntryNo: Integer;
    begin
        if ReservationEntry.FindLast() then
            ReserveEntryNo := ReservationEntry."Entry No." + 1
        else
            ReserveEntryNo := 1;

        ReservationEntry.Reset();

        ReservationEntry."Entry No." := ReserveEntryNo;
        ReservationEntry.Positive := Pos;
        ReservationEntry."Item No." := ItemNo;
        ReservationEntry."Location Code" := LocationCode;
        ReservationEntry."Quantity (Base)" := QtytoReceiveBase;
        if ReservationStatus = 3 then
            ReservationEntry."Reservation Status" := "Reservation Status"::Prospect;
        if ReservationStatus = 2 then
            ReservationEntry."Reservation Status" := "Reservation Status"::Surplus;
        ReservationEntry.Description := Desc;
        ReservationEntry."Creation Date" := today;
        ReservationEntry."Source Type" := SourceType;
        ReservationEntry."Source Subtype" := SubType;
        ReservationEntry."Source ID" := DocumentNo;
        ReservationEntry."Source Ref. No." := LineNo;
        ReservationEntry."Source Batch Name" := BatchName;
        ReservationEntry."Created By" := UserId();
        ReservationEntry."Qty. per Unit of Measure" := QtyPerUnit;
        ReservationEntry.Quantity := QtytoReceive;
        ReservationEntry."Qty. to Handle (Base)" := QtytoReceiveBase;
        ReservationEntry."Qty. to Invoice (Base)" := QtytoReceiveBase;
        ReservationEntry."Lot No." := NewLotNo;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        if PostingDate <> 0D then
            ReservationEntry."Shipment Date" := PostingDate
        else begin
            ReservationEntry."Shipment Date" := 0D;
            ReservationEntry."Expected Receipt Date" := Today;
        end;
        ReservationEntry.Insert();
    end;
}