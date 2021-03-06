package components.enum
{   
    /**
     * <!ENTITY % tablecell.color.styles "solid | vgradient | hgradient">
     */
    public class TableCellColorStyle
	{
         public static const SOLID:TableCellColorStyle          = new TableCellColorStyle(SOLID);
         public static const VGRADIENT:TableCellColorStyle      = new TableCellColorStyle(VGRADIENT);
         public static const HGRADIENT:TableCellColorStyle      = new TableCellColorStyle(HGRADIENT);

         /* Constructor */
		public function TableCellColorStyle(d:TableCellColorStyle)
		{
			/*
			 * Empty fake constructor
			 * The part that matter is that it accepts a 'copy' of itself
			 * For the recursive assignment to work
			 */
		}


        public function toString():String
        {
            switch(this) {
                case TableCellColorStyle.SOLID:
                    return "solid";
                case TableCellColorStyle.VGRADIENT:
                    return "vgradient";
                case TableCellColorStyle.HGRADIENT:
                    return "hgradient";
                default:
                    /* TableCellColorStyle.NONE is considered 'undefined' (no direction) */
                    return "undefined";
            }
        }

    }
}    