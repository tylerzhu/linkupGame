package framework.model.vos 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ItemVO 
	{
		public var id:int; //id唯一表示地图中的一个图片
		public var x:int; 
		public var y:int;
		public var icon:String; //图片的url地址
		public var flag:Boolean; //是否已经消除
		
		public function ItemVO() 
		{
			
		}
		
	}

}