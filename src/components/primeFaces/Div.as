package components.primeFaces
{
	import components.ComponentBase;

	import interfaces.IComponent;
	import interfaces.components.IDiv;

	import utils.CodeMxmlUtils;
	import utils.CodeXMLUtils;
	
	public class Div extends ComponentBase implements IDiv
	{
		private static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
    	public static var ELEMENT_NAME:String = "Div";

		private var _component:IComponent;

		private var _xml:XML;
		
		public function Div(component:IComponent = null)
		{
			super();
			
			this._component = component;
		}

		private var _isSelected:Boolean;
		public function get isSelected():Boolean
		{
			return _isSelected;
		}

		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}
				
		private var _cssClass:String = "flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop";
		public function get cssClass():String
		{
			return _cssClass;
		}
		
		public function set cssClass(value:String):void
		{
			_cssClass = value;	
		}		
		
		private var _label:String;
		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}
		
		private var _wrap:Boolean;
		public function get wrap():Boolean
		{
			return _wrap;
		}		
		
		public function set wrap(value:Boolean):void
		{
			_wrap = value;
		}		
		
		private function get component():IComponent
		{
			return _component ? _component : this;
		}
		
		public function fromXML(xml:XML, childFromXMLCallback:Function):void
		{
			this._xml = xml;
			
			setComponentSize(xml);
			
			this.wrap = xml.@wrap == "true";
			if (xml.@["class"])
			{
				this._cssClass = xml.@["class"];
			}
	
            var elementsXML:XMLList = xml.elements();
            var childCount:int = elementsXML.length();
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                childFromXMLCallback(component, childXML);
            }
		}
		
		public function toCode():XML
		{
			var xml:XML = new XML("<" + CodeMxmlUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");

            CodeXMLUtils.addSizeHtmlStyleToXML(xml, this as IComponent);

			///TODO: Adjust for Visual Editor
            xml["@class"] = _cssClass;

            var elementCount:int = component["numElements"];
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IComponent = component["getElementAt"](i) as IComponent;
                xml.appendChild(element.toCode());
            }

            return xml;
		}
	}
}