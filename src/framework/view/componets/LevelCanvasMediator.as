package framework.view.componets
{
	import flash.events.Event;
	import framework.ApplicationConstants;
	import framework.view.componets.ui.LevelCanvas;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import utils.MyEvent;
	
	/**
	 * TODO:CLASS COMMENTS
	 * @author Tylerzhu
	 */
	public class LevelCanvasMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LevelCanvasMediator";
		
		/** viewComponent local reference */
		private var levelCanvas:LevelCanvas;
		
		public function LevelCanvasMediator(initViewComponent:LevelCanvas)
		{
			super(NAME, initViewComponent);
			this.levelCanvas = initViewComponent;
			this.levelCanvas.addEventListener(ApplicationConstants.SEND_2_FRAME, onSend2Frame);
		}
		
		override public function onRegister():void
		{
		}
		
		override public function onRemove():void
		{
		}
		
		override public function listNotificationInterests():Array
		{
			return [ //
				ApplicationConstants.SHOW_LEVEL_DATA, ApplicationConstants.UPDATE_LEVEL_DATA];
		}
		
		override public function handleNotification(notice:INotification):void
		{
			switch (notice.getName())
			{
				case ApplicationConstants.SHOW_LEVEL_DATA: 
					levelCanvas.show(notice.getBody());
					break;
				case ApplicationConstants.UPDATE_LEVEL_DATA:
					levelCanvas.update(notice.getBody());
					break;
				default: 
					trace(" WARNING : LevelCanvasMediator does not handle notificotion:", notice.getName());
					break;
			}
		}
		
		private function onSend2Frame(e:MyEvent):void
		{
			sendNotification(e.body.event, e.body.data);
		}
	}
}