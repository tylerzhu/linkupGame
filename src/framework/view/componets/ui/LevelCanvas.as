package framework.view.componets.ui
{
	import com.as3game.asset.AssetManager;
	import com.as3game.time.GameTimer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import framework.ApplicationConstants;
	import framework.model.vos.ItemVO;
	import framework.view.componets.ui.dialogs.ResultDialog;
	import framework.view.componets.ui.items.SpriteItem;
	import utils.LinkUpAlg1;
	import utils.MyEvent;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class LevelCanvas extends Sprite
	{
		
		public function LevelCanvas()
		{
		
		}
		
		public function show(data:Object):void
		{
			m_data = data;
			m_curLev = data.level;
			m_levelData = data.levelData;
			m_time = data.time;
			m_restTime = data.time;
			m_sortNum = data.sortNum;
			m_tipNum = data.tipNum;
			
			if (m_view == null)
			{
				AssetManager.getInstance().getAsset("res/swfs/Res.swf", function(content:MovieClip):void
					{
						initialze();
					});
			}
			else
			{
				update(data);
			}
		}
		
		public function update(data:Object):void
		{
			m_levelData = data.levelData;
			
			while (m_view["mItemList"].numChildren > 0)
			{
				m_view["mItemList"].removeChildAt(0);
			}
			var len:int = m_levelData.length;
			var spriteItem:SpriteItem;
			var eraseNum:int = 0; //记录消除格子的数量
			for (var i:int = 0; i < len; i++)
			{
				if (m_levelData[i].flag) //已经消除
				{
					eraseNum++;
					continue;
				}
				spriteItem = new SpriteItem(m_levelData[i])
				spriteItem.addEventListener("SpriteItem.Select", onClickSpriteItem)
				spriteItem.x = m_levelData[i].x * 65 + 25;
				spriteItem.y = m_levelData[i].y * 65 + 50;
				m_view["mItemList"].addChild(spriteItem)
			}
		
			if (eraseNum == len) 
			{
				GameTimer.getInstance().unregister("time");
				var dialog:ResultDialog = new ResultDialog(true);
				dialog.addEventListener("nextLevel", onNextLevel);
				dialog.show();
			}
		}
		
		private function onClickSpriteItem(e:MyEvent):void
		{
			m_currItem = e.body.data;
			if (m_prevItem != null)
			{
				//判断2点是否可以连接消除
				var prevPoint:Point = new Point(m_prevItem.x, m_prevItem.y);
				var currPoint:Point = new Point(m_currItem.x, m_currItem.y);
				if (LinkUpAlg1.isLinkUp(prevPoint, currPoint, m_levelData))
				{
					//可消除
					var arr:Array = LinkUpAlg1.path;
					var sprite:Sprite = new Sprite();
					sprite.x = m_view["mItemList"].x;
					sprite.y = m_view["mItemList"].y;
					addChildAt(sprite, this.numChildren);
					for (var j:int = 0; j < arr.length - 1; j++)
					{
						sprite.graphics.lineStyle(4, 0xFF0000);
						sprite.graphics.moveTo(arr[j].x * 65 + 25, arr[j].y * 65 + 50);
						sprite.graphics.lineTo(arr[j + 1].x * 65 + 25, arr[j + 1].y * 65 + 50);
					}
					
					setTimeout(function():void
						{
							//
							removeChild(sprite);
							(e.body as SpriteItem).selected = true;
							m_prevItem.flag = true;
							m_currItem.flag = true;
							update(m_data);
							//
							//重置之前和当前选中Item
							m_prevItem = m_currItem = null;
						}, 100);
					
					return;
				}
			}
			
			m_prevItem = m_currItem;
			var len:int = m_view["mItemList"].numChildren;
			var spriteItem:SpriteItem;
			for (var i:int = 0; i < len; i++)
			{
				spriteItem = m_view["mItemList"].getChildAt(i) as SpriteItem;
				if (spriteItem != null)
				{
					if (spriteItem.data.id == e.body.data.id)
					{
						spriteItem.selected = true;
					}
					else
					{
						spriteItem.selected = false;
					}
				}
			}
		
		}
		
		private function initialze():void
		{
			m_view = AssetManager.getInstance().getMovieClipByName("Res.LevelView");
			if (m_view != null)
			{
				addChild(m_view);
				m_prevItem = m_currItem = null;
				update(m_data);
				
				//开始计时
				m_view["tf_time"].text = m_time + "秒";
				GameTimer.getInstance().register("time", 1000, m_time, updateTime);
				m_view["mc_pause"].addEventListener(MouseEvent.CLICK, onStopTime);
				
				//
				m_view["tf_resortNum"].text = "剩余" + m_sortNum + "次";
				m_view["mc_resort"].addEventListener(MouseEvent.CLICK, onReSort);
				m_view["tf_tipNum"].text = "剩余" + m_tipNum + "次";
				m_view["mc_tip"].addEventListener(MouseEvent.CLICK, onGetTip);
			}
		}
		
		private function onStopTime(e:MouseEvent):void
		{
			if (m_view["mc_pause"]["tf_pause"].text == "暂停")
			{
				GameTimer.getInstance().unregister("time");
				m_view["mc_pause"]["tf_pause"].text = "继续";
				m_view["mItemList"].visible = false;
			}
			else
			{
				GameTimer.getInstance().register("time", 1000, m_restTime, updateTime);
				m_view["mc_pause"]["tf_pause"].text = "暂停";
				m_view["mItemList"].visible = true;
			}
		}
		
		private function onGetTip(e:MouseEvent):void
		{
		
		}
		
		private function onReSort(e:MouseEvent):void
		{
			if (m_sortNum >= 1)
			{
				m_sortNum -= 1;
				m_view["tf_resortNum"].text = "剩余" + m_sortNum + "次";
				dispatchEvent(new MyEvent(ApplicationConstants.SEND_2_FRAME, {"event": ApplicationConstants.RESORT_LEVEL_DATA}));
			}
		}
		
		private function updateTime(currCount:int):void
		{
			if (currCount == m_time)
			{
				m_restTime = 0;
				//时间用完了
				var dialog:ResultDialog = new ResultDialog(false);
				dialog.addEventListener("reStart", onReStart);
				dialog.show();
				return;
			}
			m_restTime = (m_restTime - currCount);
			m_view["tf_time"].text = m_restTime + "秒";
			m_view["mc_time"].width = 600 - currCount * (600 / m_time);
		}
		
		private function onReStart(e:MyEvent):void 
		{
			GameTimer.getInstance().unregister("time");
			dispatchEvent(new MyEvent(ApplicationConstants.SEND_2_FRAME, { "event": ApplicationConstants.SELECT_LEVEL, "data":m_curLev } ));
		}
		
		private function onNextLevel(evt:MyEvent):void 
		{
			GameTimer.getInstance().unregister("time");
			dispatchEvent(new MyEvent(ApplicationConstants.SEND_2_FRAME, { "event": ApplicationConstants.SELECT_LEVEL, "data":m_curLev + 1 } ));
		}
		
		private var m_view:MovieClip;
		private var m_data:Object;
		private var m_curLev:int;
		private var m_levelData:Array;
		private var m_time:int;
		private var m_restTime:int;
		private var m_sortNum:int;
		private var m_tipNum:int;
		
		private var m_prevItem:ItemVO;
		private var m_currItem:ItemVO;
	}

}