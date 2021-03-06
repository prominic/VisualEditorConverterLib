package components.primeFaces
{
	import components.ComponentBase;
	import interfaces.components.ISelectOneListbox;
	import vo.SelectItem;
	import utils.CodeXMLUtils;
	import utils.CodeMxmlUtils;

	public class SelectOneListbox extends ComponentBase implements ISelectOneListbox
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "selectOneListbox";
        public static const ELEMENT_NAME:String = "SelectOneListbox";

		public function SelectOneListbox()
		{
			super();
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
		
		private var _value:String;
		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}
		
		private var _dataProvider:Array = [];
		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
		}
		
		public function fromXML(xml:XML, childFromXMLCallback:Function):void
		{
			this.setComponentSize(xml);

			this.value = xml.@value;

			var tmpItem:SelectItem;
			
			for each (var i:XML in xml.selectItem)
			{
				tmpItem = new SelectItem();
				tmpItem.itemLabel = i.@itemLabel;
				tmpItem.itemValue = i.@itemValue;
				this.dataProvider.push(tmpItem);
			}
		}
		
		public function toCode():XML
		{
			var xml:XML = new XML("<" + CodeMxmlUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
			var facetNamespace:Namespace = new Namespace("f", "http://xmlns.jcp.org/jsf/core");
			var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			xml.addNamespace(primeFacesNamespace);
			xml.setNamespace(primeFacesNamespace);

            CodeXMLUtils.addSizeHtmlStyleToXML(xml, this);
			
			if (this.value && this.value != "null")
			{
            		xml["@value"] = this.value;
			}
			
			var itemXML:XML;
			for each (var item:SelectItem in dataProvider)
			{
				itemXML = new XML("<selectItem />");
				itemXML.addNamespace(facetNamespace);
				itemXML.setNamespace(facetNamespace);
				itemXML["@itemLabel"] = item.itemLabel;
				if (item.itemValue)
				{
					itemXML["@itemValue"] = item.itemValue;
				}
				
				xml.appendChild(itemXML);
			}

            return xml;
		}
	}
}