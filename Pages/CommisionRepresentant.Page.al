page 51010 "CommisionRepresentant"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CommissionRepresentant";
    //TODO: faire page

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