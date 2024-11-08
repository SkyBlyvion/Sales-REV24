table 51009 CommissionRepresentant
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code Vendeur"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code Vendeur';
            ToolTip = 'Code du vendeur';
            Description = 'CODE_VENDEUR LN 07/11/24 REV24';
            Editable = true;
            TableRelation = "Salesperson/Purchaser".Code;
            NotBlank = true;
        }
        field(2; "Type remise"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Type remise';
            ToolTip = 'Type de remise';
            Description = 'TYPE_REMISE LN 07/11/24 REV24';
            Editable = true;
        }
        field(3; RFA; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RFA';
            ToolTip = 'RFA';
            Description = 'RFA LN 07/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(4; "% commision"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commision';
            ToolTip = 'Commision';
            Description = 'COMMISION LN 07/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            MinValue = 0;
            MaxValue = 100;
        }
    }
    keys
    {
        key(PK; "Code Vendeur", "Type remise", "RFA")
        {
            Clustered = true;
            // Primary key combining salesperson code, discount type, and RFA status
        }
    }
# pragma warning disable AA0245
    procedure CalculerCommission(CodeVendeur: Code[10]; "%RemiseLigne": Decimal; RFA: Boolean) Commission: Decimal
# pragma warning restore
    var
        TypeRemise: Record "TypeRemise";
    begin
        Commission := 0;
        // Initialize commission to zero
        IF GET(CodeVendeur, TypeRemise.RetournerTypeRemise("%RemiseLigne", CodeVendeur, RFA), RFA) THEN
            Commission := "% commision";
        // Calculate commission based on retrieved data
    end;
}