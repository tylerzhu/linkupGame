package framework.view.componets.ui
{
	import com.as3game.asset.AssetManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import framework.ApplicationConstants;
	import utils.MyEvent;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class ChooseLevCanvas extends Sprite
	{
		
		public function ChooseLevCanvas()
		{
			AssetManager.getInstance().getAsset("res/swfs/Res.swf", function(content:MovieClip):void
				{
					m_view = new MovieClip();
					addChild(m_view);
					initialze();
				});
		}
		
		private function initialze():void
		{
			//
			//2行，5列排版
			var item:MovieClip;
			for (var i:int = 0; i < 10; i++)
			{
				item = AssetManager.getInstance().getMovieClipByName("Res.LevelItem");
				if (item != null)
				{
					item.name = "level_" + (i + 1);
					item["tf_lev"].text = (i + 1);
					item.lock.visible = false;
					item.addEventListener(MouseEvent.CLICK, onChooseLevel)
					if (i < 5)
					{
						item.x = 100 + i * 75;
						item.y = 100
					}
					else
					{
						item.x = 100 + (i - 5) * 75;
						item.y = 200
					}
					
					m_view.addChild(item)
				}
			}
		}
		
		private function destroy():void
		{
		
		}
		
		private function onChooseLevel(e:MouseEvent):void
		{
			var data:Object = {};
			data.event = ApplicationConstants.SELECT_LEVEL;
			data.data = e.currentTarget.name.split("_")[1];
			dispatchEvent(new MyEvent(ApplicationConstants.SEND_2_FRAME, data));
			
			//隐藏关卡选择菜单
			m_view.visible = false;
		}
		
		private var m_view:MovieClip;
	}

}