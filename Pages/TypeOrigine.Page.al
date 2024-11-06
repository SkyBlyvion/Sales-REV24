page 51004 "TypeOrigine"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'TypeOrigine';
    AdditionalSearchTerms = 'type origine';
    UsageCategory = Lists;
    SourceTable = "TypeOrigine";

    layout
    {
        area(Content)
        {
            repeater(Général)
            {
                field(Nature; Rec.Nature)
                {
                    Caption = 'Nature';
                    ToolTip = 'Nature';
                    Editable = true;
                    BlankNumbers = DontBlank;
                }
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Code';
                    Editable = true;
                }
                field(Désignation; Rec.Désignation)
                {
                    Caption = 'Désignation';
                    ToolTip = 'Désignation';
                    Editable = true;
                }
            }
        }
    }
}