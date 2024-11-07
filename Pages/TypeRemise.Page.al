page 51012 "TypeRemise"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TypeRemise;

    layout
    {
        area(Content)
        {
            repeater(Général)
            {
                field(Name; NameSource)
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}