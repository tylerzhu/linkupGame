package framework.view.componets.ui.items
{
	import com.as3game.asset.AssetManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import utils.MyEvent;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class SpriteItem extends Sprite
	{
		
		public function SpriteItem(data:Object)
		{
			m_data = data;
			AssetManager.getInstance().getAsset(m_data.icon, function(bitmap:Bitmap):void
				{
					initialize();
				});
		}
		
		/**
		 * 更新头像单元信息
		 * @param	data
		 */
		public function update(data:Object):void
		{
			m_data = data;
		}
		
		public function get data():Object 
		{
			return m_data;
		}
		
		/**
		 * 设置是否选中状态
		 * @param	flag
		 */
		public function set selected(flag:Boolean):void 
		{
			m_selected = flag;
			if (flag) 
			{
				m_view.gotoAndStop(3);
			}
			else 
			{
				m_view.gotoAndStop(1);
			}
		}
		
		private function initialize():void
		{
			if (m_view == null)
			{
				m_view = AssetManager.getInstance().getMovieClipByName("Res.SpriteItem");
				var bitmapData:BitmapData = AssetManager.getInstance().bulkLoader.getBitmapData(m_data.icon);
				var bmp:Bitmap = new Bitmap(bitmapData);
				bmp.width = 60;
				bmp.height = 60;
				m_view["icon"].addChild(bmp);
				m_view.gotoAndStop(1);
				addChild(m_view);
				
				m_view.buttonMode = true;
				m_view.addEventListener(MouseEvent.CLICK, onClickHander);
				m_view.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				m_view.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		private function destroy():void
		{
			m_view.removeEventListener(MouseEvent.CLICK, onClickHander);
			m_view.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			m_view.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			while (m_view.numChildren > 0)
			{
				m_view.removeChildAt(0);
			}
			m_view = null;
		}
		
		private function onClickHander(e:MouseEvent):void
		{
			dispatchEvent(new MyEvent("SpriteItem.Select", this));
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			m_selected || m_view.gotoAndStop(1);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			m_selected || m_view.gotoAndStop(2);
		}
		
		private var m_view:MovieClip;
		private var m_data:Object;
		private var m_selected:Boolean;
	}

}