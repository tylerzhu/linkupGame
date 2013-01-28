package framework.controller.boostraps
{
	import framework.ApplicationConstants;
	import framework.controller.commands.ChooseLevCommand;
	import framework.controller.commands.ReSortCommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 注册Command ，建立 Command 与Notification 之间的映射
	 * @author Tylerzhu
	 */
	public class BootstrapCommands extends SimpleCommand
	{
		
		override public function execute(notice:INotification):void
		{
			//选择关卡等级
			facade.registerCommand(ApplicationConstants.SELECT_LEVEL, ChooseLevCommand);
			facade.registerCommand(ApplicationConstants.RESORT_LEVEL_DATA, ReSortCommand);
		}
	
	}
}