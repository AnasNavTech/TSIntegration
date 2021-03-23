page 70102 "Item Staging Entity TS"
{
    Caption = 'Item Staging Entity - TS';
    PageType = API;
    DelayedInsert = true;
    APIPublisher = 'TS';
    APIGroup = 'TSGroup';
    APIVersion = 'v2.0';
    SourceTable = "Item Staging TS";
    EntityName = 'Items';
    EntitySetName = 'itemsTS';
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
                field(TSItemNo; Rec."TS Item No.")
                {
                    Caption = 'TS Item No.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field(ItemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                field(BaseUnitofMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                    ApplicationArea = All;
                }
                field(PurchUnitofMeasure; Rec."Purchase Unit of Measure")
                {
                    Caption = 'Purchase Unit of Measure';
                    ApplicationArea = All;
                }
                field(SalesUnitofMeasure; Rec."Sales Unit of Measure")
                {
                    Caption = 'Sales Unit of Measure';
                    ApplicationArea = All;
                }
                field(BasetoPurchUOMRelation; Rec."Base to Purchase UOM Relation")
                {
                    Caption = 'Base to Purchase UOM Relation';
                    ApplicationArea = All;
                }
                field(BasetoSalesUOMRelation; Rec."Base to Sales UOM Relation")
                {
                    Caption = 'Base to Sales UOM Relation';
                    ApplicationArea = All;
                }
                field(UnitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ApplicationArea = All;
                }
                field(OD1; Rec.OD1)
                {
                    Caption = 'OD1';
                    ApplicationArea = All;
                }
                field(OD2; Rec.OD2)
                {
                    Caption = 'OD2';
                    ApplicationArea = All;
                }
                field(WT1; Rec.WT1)
                {
                    Caption = 'WT1';
                    ApplicationArea = All;
                }
                field(WT2; Rec.WT2)
                {
                    Caption = 'WT2';
                    ApplicationArea = All;
                }
                field(GradeType; Rec."Grade Type")
                {
                    Caption = 'Grade Type';
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    Caption = 'Grade';
                    ApplicationArea = All;
                }
                field(ProductType; Rec."Product Type")
                {
                    Caption = 'Product Type';
                    ApplicationArea = All;
                }
                field(Attribute8; Rec."Attribute 8")
                {
                    Caption = 'Attribute 8';
                    ApplicationArea = All;
                }
                field(Attribute9; Rec."Attribute 9")
                {
                    Caption = 'Attribute 9';
                    ApplicationArea = All;
                }
                field(Attribute10; Rec."Attribute 10")
                {
                    Caption = 'Attribute 10';
                    ApplicationArea = All;
                }
                field(Attribute11; Rec."Attribute 11")
                {
                    Caption = 'Attribute 11';
                    ApplicationArea = All;
                }
                field(Attribute12; Rec."Attribute 12")
                {
                    Caption = 'Attribute 12';
                    ApplicationArea = All;
                }
                field(Attribute13; Rec."Attribute 13")
                {
                    Caption = 'Attribute 13';
                    ApplicationArea = All;
                }
                field(Attribute14; Rec."Attribute 14")
                {
                    Caption = 'Attribute 14';
                    ApplicationArea = All;
                }
                field(Attribute15; Rec."Attribute 15")
                {
                    Caption = 'Attribute 15';
                    ApplicationArea = All;
                }
                field(Attribute16; Rec."Attribute 16")
                {
                    Caption = 'Attribute 16';
                    ApplicationArea = All;
                }
                field(Attribute17; Rec."Attribute 17")
                {
                    Caption = 'Attribute 17';
                    ApplicationArea = All;
                }
                field(Attribute18; Rec."Attribute 18")
                {
                    Caption = 'Attribute 18';
                    ApplicationArea = All;
                }
                field(Attribute19; Rec."Attribute 19")
                {
                    Caption = 'Attribute 19';
                    ApplicationArea = All;
                }
                field(Attribute20; Rec."Attribute 20")
                {
                    Caption = 'Attribute 20';
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