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
        field(3; Nature; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Nature';
            ToolTip = 'Nature';
            Editable = false;
            BlankNumbers = DontBlank;
            OptionMembers = " ","Commande","","Avoir",,;
        }
    }

    keys
    {
        key(PK; Nature, Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}