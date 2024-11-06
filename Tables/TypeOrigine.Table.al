table 51002 TypeOrigine
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            ToolTip = 'Code';
            Editable = true;
        }
        field(2; Désignation; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Désignation';
            ToolTip = 'Désignation';
            Editable = true;
        }
        field(3; Nature; Enum NatureEnum)
        {
            DataClassification = CustomerContent;
            Caption = 'Nature';
            ToolTip = 'Nature';
            Editable = false;
            BlankNumbers = DontBlank;
            //OptionMembers = " ","Commande","0","Avoir","2";
        }
    }

    keys
    {
        key(PK; Nature, Code)
        {
            Clustered = true;
        }
    }
}