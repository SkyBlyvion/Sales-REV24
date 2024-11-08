table 51011 "TypeRemise"
{
    /*
        Documentation()
        //* NSC2.07 : Il faut se référer à la liste des types de remise du vendeur .
        // Permet de calculer les commissions et type de remise.
        
    */

    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            ToolTip = 'Code';
            Description = 'TYPE_REMISE LN 07/11/24 REV24';
            Editable = true;
        }
        field(2; "Opérateur borne inférieure"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Opérateur borne inférieure';
            ToolTip = 'Opérateur borne inférieure';
            Description = 'TYPE_REMISE LN 07/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            OptionMembers = ">=",">","<=","<";
        }
        field(3; "Borne inférieure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Borne inférieure';
            ToolTip = 'Borne inférieure';
            Description = 'TYPE_REMISE LN 07/11/24 REV24';
            MinValue = 0;
            MaxValue = 100;
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(4; "Opérateur borne supérieure"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Opérateur borne supérieure';
            ToolTip = 'Opérateur borne supérieure';
            Description = 'TYPE_REMISE LN 07/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
            OptionMembers = ">=",">","<=","<";
        }
        field(5; "Borne supérieure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Borne supérieure';
            ToolTip = 'Borne supérieure';
            Description = 'TYPE_REMISE LN 07/11/24 REV24';
            MinValue = 0;
            MaxValue = 100;
            Editable = true;
            BlankNumbers = DontBlank;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    procedure RetournerTypeRemise(Remise: Decimal; "Code Vendeur": Code[20]; RFA: Boolean) TypeRemise: Code[15]
    var
        CommVendeur: Record "CommissionRepresentant";
    begin
        FIND('-');
        REPEAT

            IF CommVendeur.GET("Code Vendeur", Code, RFA) THEN BEGIN //* NSC2.07 : Il faut se référer à la liste des types de remise du vendeur

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">=") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::">=")
                THEN
                    IF (Remise >= "Borne inférieure") AND (Remise >= "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">=") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::">")
                THEN
                    IF (Remise >= "Borne inférieure") AND (Remise > "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">=") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::"<")
                THEN
                    IF (Remise >= "Borne inférieure") AND (Remise < "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">=") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::"<=")
                THEN
                    IF (Remise >= "Borne inférieure") AND (Remise <= "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::">=")
                THEN
                    IF (Remise > "Borne inférieure") AND (Remise >= "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::">")
                THEN
                    IF (Remise > "Borne inférieure") AND (Remise > "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::"<")
                THEN
                    IF (Remise > "Borne inférieure") AND (Remise < "Borne supérieure") THEN
                        TypeRemise := Code;

                IF ("Opérateur borne inférieure" = "Opérateur borne inférieure"::">") AND
                ("Opérateur borne supérieure" = "Opérateur borne supérieure"::"<=")
                THEN
                    IF (Remise > "Borne inférieure") AND (Remise <= "Borne supérieure") THEN
                        TypeRemise := Code;

            END; //* NSC2.07 : Il faut se référer à la liste des types de remise du vendeur

        UNTIL NEXT() = 0;
    end;

}