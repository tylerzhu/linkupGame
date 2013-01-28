package framework.view.componets
{
	import framework.ApplicationConstants;
	import framework.view.componets.ui.ChooseLevCanvas;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import utils.MyEvent;
	
	/**
	 * TODO:CLASS COMMENTS
	 * @author Tylerzhu
	 */
	public class ChooseLevCanvasMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "SelectCanvasMediator";
		
		/** viewComponent local reference */
		private var selectCanvas:ChooseLevCanvas;
		
		public function ChooseLevCanvasMediator(initViewComponent:ChooseLevCanvas)
		{
			super(NAME, initViewComponent);
			this.selectCanvas = initViewComponent;
			this.selectCanvas.addEventListener(ApplicationConstants.SEND_2_FRAME, onSend2Frame);
		}
		
		/*override public function setViewComponent(newViewComponent:SelectCanvas):void
		   {
		   this.selectCanvas = newViewComponent;
		   super.setViewComponent(newViewComponent);
		 }*/
		
		override public function onRegister():void
		{
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
					trace(" WARNING : SelectCanvasMediator does not handle notificotion:", notice.getName());
					break;
			}
		}
		
		/**
		 * 将来自UI的事件转发给框架
		 * @param	e
		 */
		private function onSend2Frame(e:MyEvent):void
		{
			sendNotification(e.body.event, e.body.data);
		}
	}
}