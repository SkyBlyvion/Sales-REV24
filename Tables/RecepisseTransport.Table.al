table 51013 "RecepisseTransport"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No. préparation"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. préparation';
            ToolTip = 'No. préparation';
            Description = 'RECEPISSE_TRANSPORT LN 07/11/24 REV24';
            Editable = true;
        }
        field(2; "Date recepisse"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date recepisse';
            ToolTip = 'Date recepisse';
            Description = 'RECEPISSE_TRANSPORT LN 07/11/24 REV24';
            Editable = true;
            BlankNumbers = DontBlank;
        }
        field(3; "No. BL"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. BL';
            ToolTip = 'No. BL';
            Description = 'RECEPISSE_TRANSPORT LN 07/11/24 REV24';
            Editable = true;
        }
        field(4; "No. client"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. client';
            ToolTip = 'No. client';
            Description = 'RECEPISSE_TRANSPORT LN 07/11/24 REV24';
            Editable = true;
        }
    } //TODO:Finir table

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

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