page 51010 "CommissionRepresentant"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CommissionRepresentant";

    layout
    {
        area(Content)
        {
            repeater(Général)
            {
                field("Code Vendeur"; Rec."Code Vendeur")
                {
                    Caption = 'Code Vendeur';
                    ToolTip = 'Code du vendeur';
                    Editable = true;
                    Visible = false;
                }
                field("Type remise"; Rec."Type remise")
                {
                    Caption = 'Type remise';
                    ToolTip = 'Type de remise';
                    Editable = true;
                    Visible = true;
                }
                field("RFA"; Rec."RFA")
                {
                    Caption = 'RFA';
                    ToolTip = 'RFA';
                    Editable = true;
                    Visible = true;
                }
                field("% Commission"; Rec."% commision")
                {
                    Caption = '% Commission';
                    ToolTip = 'Commission en pourcentage';
                    Editable = true;
                    Visible = true;
                }
            }
        }
    }
}