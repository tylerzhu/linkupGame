package framework.view
{
	import flash.display.DisplayObjectContainer;
	import framework.view.componets.ChooseLevCanvasMediator;
	import framework.view.componets.LevelCanvasMediator;
	import framework.view.componets.ui.ChooseLevCanvas;
	import framework.view.componets.ui.LevelCanvas;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * TODO:CLASS COMMENTS
	 * @author Tylerzhu
	 */
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(initViewComponent:DisplayObjectContainer)
		{
			super(NAME);
			this.rootView = initViewComponent;
			
			initCanvas();
		}
		
		override public function onRegister():void
		{
			facade.registerMediator(new ChooseLevCanvasMediator(m_chooseLevCanvas));
			facade.registerMediator(new LevelCanvasMediator(m_levelCanvas));
		}
		
		override public function onRemove():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [ //
				];
		}
		
		override public function handleNotification(notice:INotification):void
		{
			switch (notice.getName())
			{
				default: 
					trace(" WARNING : StageMediator does not handle notificotion:", notice.getName());
					break;
			}
		}
		
		private function initCanvas():void
		{
			//关卡选择界面
			m_chooseLevCanvas = new ChooseLevCanvas();
			rootView.addChild(m_chooseLevCanvas);
			
			//具体关卡界面
			m_levelCanvas = new LevelCanvas();
			rootView.addChild(m_levelCanvas);
		}
		
		private var rootView:DisplayObjectContainer;
		private var m_levelCanvas:LevelCanvas;
		private var m_chooseLevCanvas:ChooseLevCanvas;
	}
}