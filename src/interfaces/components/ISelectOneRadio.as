package interfaces.components
{
	import interfaces.IComponent;

	public interface ISelectOneRadio extends IComponent, IIsSelected
	{
		function get columns():int;
		function set columns(value:int):void;
		
		function get value():String;
		function set value(value:String):void;
	}
}