tableextension 70108 "Vendor Ext" extends Vendor
{
    fields
    {
        field(70100; Type; Enum "Vendor Type TS")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(70101; "TS ID."; text[50])
        {
            Caption = 'Last Synced TS ID.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70102; "Send to TS"; Boolean)
        {
            Caption = 'Send to TS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70103; "TS Error Message"; Text[250])
        {
            Caption = 'TS Error Message';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70104; "TS Sync Status"; Enum "Push Data Sync Status TS")
        {
            DataClassification = CustomerContent;
            Caption = 'TS Sync Status';
            Editable = false;
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeInsert()
    begin
        if ("No." <> '') and (Name <> '') and (Address <> '') then begin
            "Send to TS" := false;
            "TS Sync Status" := "TS Sync Status"::"Waiting for Sync";
            InsertVendorContractorStaging();
        end else begin
            "Send to TS" := false;
            "TS Sync Status" := "TS Sync Status"::"InComplete Data";
        end;
    end;

    trigger OnBeforeModify()
    begin
        if ("No." <> '') and (Name <> '') and (Address <> '') then begin
            if (Rec.Name <> xRec.Name) or (Rec.Address <> xRec.Address) then begin
                "Send to TS" := false;
                "TS Sync Status" := "TS Sync Status"::"Waiting for Sync";
                InsertVendorContractorStaging();
            end;
        end else begin
            "Send to TS" := false;
            "TS Sync Status" := "TS Sync Status"::"InComplete Data";
        end;
    end;

    procedure InsertVendorContractorStaging()
    var
        VendorContractor: Record "Vendor Contractor TS";
        EntryNo: Integer;
    begin
        VendorContractor.Reset();
        if VendorContractor.FindLast() then
            EntryNo := VendorContractor."Entry No." + 1
        else
            EntryNo := 1;
        VendorContractor.Init();
        VendorContractor."Entry No." := EntryNo;
        VendorContractor.Code := "No.";
        VendorContractor.Name := Name;
        VendorContractor.Type := Type;
        VendorContractor.Address := Address;
        VendorContractor."Created By" := UserId();
        VendorContractor."Created On" := Today();
        VendorContractor."TS Sync Status" := VendorContractor."TS Sync Status"::"Waiting for Sync";
        VendorContractor.Insert();
    end;
}