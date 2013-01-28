package framework
{
	
	/**
	 * 定义框架中用于通信的事件，通常事件的命名规则是：
	 * 		动词_名词(*)
	 * 表示要做什么事情，如弹出一个对话框： SHOW_DIALOG
	 * @author Tylerzhu
	 */
	public class ApplicationConstants
	{
		//
		public static const SEND_2_FRAME:String = "send_2_frame"; //消息需要发送到框架
		
		//关卡选择模块事件
		public static const SELECT_LEVEL:String = "select_level";
		
		//具体关卡模块事件
		public static const SHOW_LEVEL_DATA:String = "show_level_data";
		public static const UPDATE_LEVEL_DATA:String = "update_level_data";
		public static const RESORT_LEVEL_DATA:String = "resort_level_data";
		
		//
		public static const GAME_OVER:String = "game_over";
	}

}