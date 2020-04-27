package interfaces.dominoComponents
{
	import interfaces.IComponent;
    import interfaces.IIsSelected;

    public interface IDominoInputText extends IComponent, IIsSelected
	{
		function get text():String;
		function set text(value:String):void;
		
		function get maxLength():String;
		function set maxLength(value:String):void;
		
		function get idAttribute():String;
		function set idAttribute(value:String):void;
		
		function get required():Boolean;
		function set required(value:Boolean):void;

		function get allowmultivalues():Boolean;
		function set allowmultivalues(value:Boolean):void;

		function get nameAttribute():String;
		function set nameAttribute(value:String):void;

		function get type():String;
		function set type(value:String):void;

		function get kind():String;
		function set kind(value:String):void;


		function get width():Number;
		function set width(value:Number):void;

		function get height():Number;
		function set height(value:Number):void;


		function get format():String;
		function set format(value:String):void;
		function get digits():String;
		function set digits(value:String):void;
		function get punctuated():Boolean;
		function set punctuated(value:Boolean):void;
		function get parens():Boolean;
		function set parens(value:Boolean):void;
		function get percent():Boolean;
		function set percent(value:Boolean):void;


		function get show():String;
		function set show(value:String):void;
		function get date():String;
		function set date(value:String):void;
		function get showtodaywhenappropriate():Boolean;
		function set showtodaywhenappropriate(value:Boolean):void;
		function get fourdigityear():Boolean;
		function set fourdigityear(value:Boolean):void;
		function get fourdigityearfor21stcentury():Boolean;
		function set fourdigityearfor21stcentury(value:Boolean):void;

		function get omitthisyear():Boolean;
		function set omitthisyear(value:Boolean):void;
		function get time():String;
		function set time(value:String):void;

		function get zone():String;
		function set zone(value:String):void;

		function get calendar():String;
		function set calendar(value:String):void;

	}
}