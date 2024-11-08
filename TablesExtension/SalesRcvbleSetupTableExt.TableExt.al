tableextension 51014 "SalesRcvbleSetupTableExt" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50001; "Remise article déprécié"; Decimal)
        {
            Caption = 'Remise article déprécié';
            ToolTip = 'Remise article déprécié';
            Description = 'PARAM_VENTES LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = true;
        }
        field(50002; "Remise article non déprécié"; Decimal)
        {
            Caption = 'Remise article non déprécié';
            ToolTip = 'Remise article non déprécié';
            Description = 'PARAM_VENTES LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = true;
        }
        field(50003; "Compteur Affacturage Débiteurs"; Integer)
        {
            Caption = 'Compteur Affacturage Débiteurs';
            ToolTip = 'Compteur Affacturage Débiteurs';
            Description = 'AFFACTURAGE LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = true;
        }
        field(50004; "Compteur Affacturage PNS"; Integer)
        {
            Caption = 'Compteur Affacturage PNS';
            ToolTip = 'Compteur Affacturage PNS';
            Description = 'AFFACTURAGE LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = true;
        }
        field(50005; "Compteur Affacturage Effets"; Integer)
        {
            Caption = 'Compteur Affacturage Effets';
            ToolTip = 'Compteur Affacturage Effets';
            Description = 'AFFACTURAGE LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = true;
        }
        field(50006; "Compteur FactoFrance"; Integer)
        {
            Caption = 'Compteur FactoFrance';
            ToolTip = 'Compteur FactoFrance';
            Description = 'AFFACTURAGE LN 06/11/24 REV24';
            BlankNumbers = DontBlank;
            Editable = true;
        }
    }
}