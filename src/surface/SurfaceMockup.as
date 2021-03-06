package surface
{
	import interfaces.ISurface;
	import interfaces.IComponent;
	import interfaces.IVisualComponent;
	import utils.MainTagCodeUtils;
	import interfaces.IRootComponent;
	import interfaces.components.IDiv;
	import interfaces.dominoComponents.IBody;

	public class SurfaceMockup implements ISurface, IVisualComponent, IComponent
	{
		private var _elements:Array;
	
		public function SurfaceMockup():void
		{
			_elements = [];	
		}		
		
				private var _width:Number;
		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}
		
		private var _height:Number;
		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}
		
		private var _percentWidth:Number;
		public function get percentWidth():Number
		{
			return _percentWidth;
		}

		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
		}
		
		private var _percentHeight:Number;
		public function get percentHeight():Number
		{
			return _percentHeight;
		}

		public function set percentHeight(value:Number):void
		{
			_percentHeight = value;
		}
		
		public function addItem(item:IComponent):void
		{
			
		}
		
		public function get numElements():int
		{
			if (_elements)
			{
				return _elements.length;	
			}	
			
			return 0;
		}		
		
		public function addElement(element:Object):void
		{
			_elements.push(element);		
		}
		
		public function getElementAt(index:int):Object
		{
			if (numElements > 0) 
			{
				return _elements[index]
			}
			
			return null;
		}
			
		public function fromXML(xml:XML, childFromXMLCallback:Function):void
		{
			throw new Error("Surface doesn't implement fromXML method!");
		}
		
		public function toCode():XML
		{
			var element:Object = this.getElementAt(0);
			var xml:XML = MainTagCodeUtils.getParentContent("", element as IDiv);
            var mainContainer:XML = MainTagCodeUtils.getMainContainerTag(xml);

			var elementCount:int = (element as IVisualComponent).numElements;
			
			for (var i:int = 0; i < elementCount; i++)
            {
                var item:IComponent = element.getElementAt(i) as IComponent;

                if (item === null)
                {
                        continue;
                }

			    XML.ignoreComments = false;
                var code:XML = item.toCode();
				var commentOnlyXML:XMLList = (code.elements("primeFacesCommentOnlyTag").length() > 0) ?
											  code.elements("primeFacesCommentOnlyTag") : null;
                if (mainContainer)
                {
                    mainContainer.appendChild(!commentOnlyXML ? code : commentOnlyXML.children());
                }
                else
                {
                    xml.appendChild(!commentOnlyXML ? code : commentOnlyXML.children());
                }
            }

			return xml;
		}


		public function toDominoCode():XML
		{
			var element:Object = this.getElementAt(0);
			var xml:XML = MainTagCodeUtils.getDominoParentContent("", element as IBody);
            var mainContainer:XML = MainTagCodeUtils.getMainContainerTag(xml);

			var elementCount:int = (element as IVisualComponent).numElements;
			
			for (var i:int = 0; i < elementCount; i++)
            {
                var item:IComponent = element.getElementAt(i) as IComponent;

                if (item === null)
                {
                        continue;
                }

			    XML.ignoreComments = false;
                var code:XML = item.toCode();
				
                if (mainContainer)
                {
                    mainContainer.appendChild(code);
                }
                else
                {
                    xml.appendChild(code);
                }
            }

			return xml;
		}
	}
}