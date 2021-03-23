page 70120 "Vendor Contractor Staging TS"
{
    Caption = 'Vendor Contractor Staging List - TS';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Vendor Contractor TS";
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
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
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
            action("Create Vendor in TubeStream")
            {
                Caption = 'Create Vendor in TubeStream';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InsertDataToTS: Page "Test API Staging TS";
                begin
                    InsertDataToTS.PushVendortoTS();
                end;
            }
        }
    }
}