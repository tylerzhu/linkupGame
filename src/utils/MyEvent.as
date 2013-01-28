package utils
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class MyEvent extends Event
	{
		
		public function MyEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			m_data = data;
		}
		
		public function get body():Object 
		{
			return m_data;
		}
		
		public override function clone():Event
		{
			return new MyEvent(type, body, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("MyEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		}
		
		private var m_data:Object;
	}

}