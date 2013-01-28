package framework.controller.commands
{
	import framework.model.LevelProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * TODO:CLASS COMMENTS
	 * @author Tylerzhu
	 */
	public class ChooseLevCommand extends SimpleCommand
	{
		
		override public function execute(notice:INotification):void
		{
			var proxy:LevelProxy = facade.retrieveProxy(LevelProxy.NAME) as LevelProxy;
			proxy.selectLevel(int(notice.getBody()));
		}
	
	}
}