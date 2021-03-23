table 70115 "Purchase Quote Lines TS"
{
    Caption = 'Purchase Quote Lines TS';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(4; "TS Item No."; Code[50])
        {
            Caption = 'TS Item No.';
            DataClassification = CustomerContent;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(8; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(10; "Ready For PO"; Boolean)
        {
            Caption = 'Ready For PO';
            DataClassification = CustomerContent;
        }
        field(11; "Internal Request No."; Code[20])
        {
            Caption = 'Internal Request No.';
            DataClassification = CustomerContent;
        }
        field(12; "Purchase Quote Line No."; Integer)
        {
            Caption = 'Purchase Quote Line No.';
            DataClassification = CustomerContent;
        }
        field(13; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(14; "Inserted By"; Text[50])
        {
            Caption = 'Inserted By';
            DataClassification = CustomerContent;
        }
        field(15; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        field(16; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Amount)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure InsertData(InternalRequestNo: Code[20])
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseHdr: Record "Purchase Header";
        OldDocumentNo: Code[20];
        InvalidRequestNoErr: Label 'Invalid Internal Request No.';
    begin
        OldDocumentNo := '';
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Quote);
        PurchaseLine.CalcFields("Internal Request No.");
        PurchaseLine.SetRange("Internal Request No.", InternalRequestNo);
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        if PurchaseLine.FindSet() then begin
            repeat
                if (OldDocumentNo <> '') and (PurchaseLine."Document No." <> OldDocumentNo) then begin
                    Init();
                    "Entry No." := FindLastEntryNo();
                    "Internal Request No." := InternalRequestNo;
                    "Inserted By" := UserId();
                    Insert();
                end;
                PurchaseHdr.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                Init();
                "Entry No." := FindLastEntryNo();
                "Document No." := PurchaseLine."Document No.";
                "Item No." := PurchaseLine."No.";
                "TS Item No." := PurchaseLine."TS Item No.";
                Description := CopyStr(PurchaseLine.Description, 50);
                Quantity := PurchaseLine.Quantity;
                "Unit Cost" := PurchaseLine."Unit Cost";
                "Unit Price" := PurchaseLine."Unit Price (LCY)";
                Amount := PurchaseLine.Amount;
                "Location Code" := PurchaseLine."Location Code";
                "Internal Request No." := InternalRequestNo;
                "Purchase Quote Line No." := PurchaseLine."Line No.";
                "Inserted By" := UserId();
                "Vendor No." := PurchaseHdr."Buy-from Vendor No.";
                "Vendor Name" := PurchaseHdr."Buy-from Vendor Name";
                Insert();
                OldDocumentNo := "Document No.";
            until PurchaseLine.Next() = 0;
        end else
            Error(InvalidRequestNoErr);
        MarkLowestAmountAsReadyForPO();
    end;

    procedure MarkLowestAmountAsReadyForPO()
    begin
        Rec.Reset();
        Rec.SetCurrentKey(Amount);
        Rec.SetFilter(Amount, '<>%1', 0);
        if Rec.FindFirst() then begin
            Rec."Ready For PO" := true;
            Rec.Modify();
        end;
        Rec.Reset();
    end;

    procedure FindLastEntryNo(): Integer
    var
        PurchaseQuoteLines: Record "Purchase Quote Lines TS";
    begin
        if PurchaseQuoteLines.FindLast() then
            Exit(PurchaseQuoteLines."Entry No." + 1);

        Exit(1);
    end;


}