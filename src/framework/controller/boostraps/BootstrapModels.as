package framework.controller.boostraps
{
	import framework.model.LevelProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 创建Proxy 对象，并注册
	 * Model的初始化通常比较简单：创建并注册在“开启”过程中需要用到的Proxy。
	 * 这里Command并没有操作或初始任何的Model数据。Proxy 的职责才是取得，创建，和初始化数据对象。
	 * @author Tylerzhu
	 */
	public class BootstrapModels extends SimpleCommand
	{
		//由MacroCommand调用
		override public function execute(notice:INotification):void
		{
			facade.registerProxy(new LevelProxy());
		}
	
	}
}