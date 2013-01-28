package
{
	import com.as3game.utils.StageUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import framework.ApplicationFacade;
	
	/**
	 * 基于PureMVC框架的"连连看"游戏，通过该实例你可以学习到：
	 * 	1. PureMVC框架的使用
	 *  2. 推荐的PureMVC项目目录结构
	 *  3. “连连看”游戏的算法设计
	 * @author
	 */
	public class LinkUpGame extends Sprite
	{
		
		public function LinkUpGame():void
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			StageUtil.stage = stage;
			//初始化PureMVC框架，并启动游戏
			ApplicationFacade.getInstance().startUp(this);
		}
	
	}

}