package com.as3game.utils
{
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	
	/**
	 * 舞台公用类： StageUtil
	 * StageUtil.stage保存全局唯一的舞台实例
	 * @author Tylerzhu
	 */
	public class StageUtil
	{
		static public function get stage():Stage
		{
			return m_stage;
		}
		
		static public function set stage(value:Stage):void
		{
			m_stage = value;
		}
		
		/**
		 * 判断舞台是否可以用
		 */
		static public function get isStageValid():Boolean
		{
			if (m_stage != null && m_stage.height != 0 && m_stage.width != 0) //m_stage.height might be 0 in some Mac computers in some cases
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 进入全屏模式
		 */
		static public function enterFullScreen():void
		{
			if (isStageValid)
			{
				m_stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}
		
		/**
		 * 退出全屏模式
		 */
		static public function exitFullScreen():void
		{
			if (isStageValid)
			{
				m_stage.displayState = StageDisplayState.NORMAL;
			}
		}
		
		/**
		 * 判断是否全屏模式
		 */
		static public function get isFullScreen():Boolean
		{
			if (isStageValid)
			{
				return m_stage.displayState == StageDisplayState.FULL_SCREEN;
			}
			return false;
		}
		
		static private var m_stage:Stage;
	
	}

}