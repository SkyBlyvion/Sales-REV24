page 51012 "TypeRemise"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'TypeRemise';
    AdditionalSearchTerms = 'type remise';
    UsageCategory = Lists;
    SourceTable = TypeRemise;

    layout
    {
        area(Content)
        {
            repeater(Général)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Code';
                    Editable = true;
                }
                field("Opérateur borne inférieure"; Rec."Opérateur borne inférieure")
                {
                    Caption = 'Opérateur borne inférieure';
                    ToolTip = 'Opérateur borne inférieure';
                    Editable = true;
                }
                field("Borne inférieure"; Rec."Borne inférieure")
                {
                    Caption = 'Borne inférieure';
                    ToolTip = 'Borne inférieure';
                    Editable = true;
                }
                field("Opérateur borne supérieure"; Rec."Opérateur borne supérieure")
                {
                    Caption = 'Opérateur borne supérieure';
                    ToolTip = 'Opérateur borne supérieure';
                    Editable = true;
                }
                field("Borne supérieure"; Rec."Borne supérieure")
                {
                    Caption = 'Borne supérieure';
                    ToolTip = 'Borne supérieure';
                    Editable = true;
                }
            }

        }
    }
}