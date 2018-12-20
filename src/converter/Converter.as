package converter
{
	import flash.events.EventDispatcher;
	
	import components.primeFaces.Button;
	import components.primeFaces.Div;
	import components.primeFaces.OutputLabel;
	import components.primeFaces.RootDiv;
	
	import events.ConverterErrorEvent;
	import events.ConverterEvent;
	
	import interfaces.IComponent;
	import interfaces.ISurface;
	
	import surface.SurfaceMockup;

	[Event(name="conversionCompleted", type="events.ConverterEvent")]
	public class Converter extends EventDispatcher
	{
		private static var _instance:Converter;
		
		public var classLookup:Object;
		private var componentsSurface:ISurface;
		
		public function Converter(classLookup:Object = null)
		{
	        if(_instance)
			{
	            throw new Error("Use getInstance()");
	        } 
	        _instance = this;

			fillClassLookupWidthData(classLookup);
	    }
	
	    public static function getInstance(classLookup:Object = null):Converter  
	    {
	        if(!_instance)
	        {
	            new Converter(classLookup);
	        } 

	        return _instance;
	    }

		public function fromXMLOnly(xml:XML):void
		{	
			var surfaceMockup:SurfaceMockup = new SurfaceMockup();

			this.fromXML(surfaceMockup, xml);
			
			var code:XML = surfaceMockup.toCode();
			this.dispatchEvent(new ConverterEvent(ConverterEvent.CONVERSION_COMPLETED, code));
		}		
		
		public function fromXML(surface:ISurface, xml:XML):void
		{
			this.componentsSurface = surface;
			
			var elements:XMLList = xml.elements();
			var elementCount:int = elements.length();
			for(var i:int = 0; i < elementCount; i++)
			{
				var elementXML:XML = elements[i];
				itemFromXML(surface, elementXML);
			}
		}
		
		private function itemFromXML(parent:Object, itemXML:XML):IComponent
		{
			var name:String = itemXML.localName();
			if(!(name in this.classLookup))
			{
                    var elements:XMLList = itemXML.elements();
                    var elementCount:int = elements.length();
                    for(var i:int = 0; i < elementCount; i++)
                    {
                        var elementXML:XML = elements[i];
                        this.itemFromXML(parent, elementXML);
                    }
				return null;
			}
			var type:Class = this.classLookup[name];
			var item:IComponent = new type() as IComponent;
			if(item === null)
			{
				var errorMessage:String = "Failed to create surface component: " + name;
				dispatchEvent(new ConverterErrorEvent(errorMessage));
				throw new Error(errorMessage);
			}
			item.fromXML(itemXML, this.itemFromXML);
			parent.addElement(item);
			componentsSurface.addItem(item);
			return item;
		}
		
		private function fillClassLookupWidthData(classLookup:Object):void
		{
			if (classLookup)
			{
				this.classLookup = classLookup;
				return;
			}
			
			this.classLookup = {};
			this.classLookup[Button.ELEMENT_NAME] = Button;
			this.classLookup[OutputLabel.ELEMENT_NAME] = OutputLabel;
			this.classLookup[Div.ELEMENT_NAME] = Div;
			this.classLookup["RootDiv"] = RootDiv;
		}
	}
}