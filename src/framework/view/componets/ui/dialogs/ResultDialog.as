package framework.view.componets.ui.dialogs 
{
	import com.as3game.asset.AssetManager;
	import com.as3game.utils.StageUtil;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import utils.MyEvent;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class ResultDialog extends Sprite 
	{
		
		public function ResultDialog(isWin:Boolean) 
		{
			m_isWin = isWin;
		}
		
		public function show():void 
		{
			AssetManager.getInstance().getAsset("res/swfs/Res.swf", function(content:MovieClip):void
				{
					m_view = AssetManager.getInstance().getMovieClipByName("Res.ResultDialog");
					addChild(m_view);
					
					if (m_isWin) 
					{
						m_view.gotoAndStop(1);
						m_view["next"].addEventListener(MouseEvent.CLICK, onNext);
					}
					else 
					{
						m_view.gotoAndStop(2);
						m_view["reStart"].addEventListener(MouseEvent.CLICK, onReStart);
					}
					
					m_view["closeBtn"].addEventListener(MouseEvent.CLICK, onClose);
					m_view.x = StageUtil.stage.width - m_view.width >> 2;
					m_view.y = StageUtil.stage.height - m_view.height >> 2;
					StageUtil.stage.addChild(m_view);
				});
		}
		
		private function onReStart(e:MouseEvent):void 
		{
			dispatchEvent(new MyEvent("reStart"));
			onClose();
		}
		
		private function onNext(e:MouseEvent):void 
		{
			dispatchEvent(new MyEvent("nextLevel"));
			onClose();
		}
		
		private function onClose(e:MouseEvent=null):void 
		{
			StageUtil.stage.removeChild(m_view);
		}
		
		private var m_view:MovieClip;
		private var m_isWin:Boolean = true;
	}

}