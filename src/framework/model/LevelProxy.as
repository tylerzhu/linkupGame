package framework.model
{
	import com.as3game.utils.RandomUtil;
	import framework.ApplicationConstants;
	import framework.model.vos.ItemVO;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * TODO:CLASS COMMENTS
	 * @author Tylerzhu
	 */
	public class LevelProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "LevelProxy";
		
		public function LevelProxy()
		{
			super(NAME);
		
		}
		
		override public function onRegister():void
		{
		}
		
		override public function onRemove():void
		{
		}
		
		/**
		 * 关卡数据的几点说明：
		 * 	1. 关卡数据可以通过关卡编辑器生成配置文件，然后读取配置文件即可。
		 * 	   这样关卡更可控，且可以摆放成各种数据。
		 * 	2. 如果做成网络版的，关卡数据也可以通过服务器端返回。
		 * 本实例为了简单，关卡数据根据等级随机生成10种图片，数量固定为40个。
		 * @param	level
		 */
		public function selectLevel(level:int):void
		{
			//选择关卡level，生成关卡数据
			m_time = 30 * (11 - level); //关卡时间
			m_sortNum = (4 - level) > 0 ? (4 - level) : 0; //前面3个挂卡分别有3、2、1次重新排列机会
			m_tipNum = 10 - level; //挂卡依次有9、8、7、6、5、4、3、2、1、0次提示机会
			
			m_levelData = new Array();
			var elem:ItemVO;
			var num:uint = 1;
			RandomUtil.clearHistory();
			for (var i:uint = 0; i < 10; i++)
			{
				var icon:String = "res/images/heroes_" + RandomUtil.integer(1, 107, false) + ".jpg";
				for (var j:int = 0; j < 4; j++)
				{
					elem = new ItemVO();
					elem.id = num++;
					elem.icon = icon;
					elem.flag = false;
					m_levelData.push(elem);
				}
			}
			
			randomLevelData();
			
			sendNotification(ApplicationConstants.SHOW_LEVEL_DATA, {"level": level, "levelData": m_levelData, "time": m_time, "sortNum": m_sortNum, "tipNum": m_tipNum});
		}
		
		/**
		 * 对当前关卡数据进行随机排列
		 */
		public function reSortLevelData():void
		{
			randomLevelData();
			
			sendNotification(ApplicationConstants.UPDATE_LEVEL_DATA, {"levelData": m_levelData});
		}
		
		private function randomLevelData():void 
		{
			m_levelData = RandomUtil.randomArray(m_levelData);
			for (var i:int = 0; i < 10; i++)
			{
				for (var j:int = 0; j < 4; j++)
				{
					m_levelData[j * 10 + i].x = i;
					m_levelData[j * 10 + i].y = j;
				}
			}
		}
		
		/** data local reference */
		private var m_levelData:Array;
		private var m_time:int;
		private var m_tipNum:int;
		private var m_sortNum:int;
	}
}