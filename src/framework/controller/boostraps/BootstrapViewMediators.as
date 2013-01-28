package framework.controller.boostraps
{
	import framework.view.ApplicationMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 创建Mediator们，并把它注册到View.
	 * @author Tylerzhu
	 */
	public class BootstrapViewMediators extends SimpleCommand
	{
		
		override public function execute(notice:INotification):void
		{
			//游戏主舞台
			var appStage:LinkUpGame = notice.getBody() as LinkUpGame;
			facade.registerMediator(new ApplicationMediator(appStage));
			//
			//sendNotification(ApplicationConstants.REQUEST_LOGIN, reqLogin);
			
		}
	}
}