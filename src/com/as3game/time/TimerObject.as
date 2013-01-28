package com.as3game.time
{
	
	/**
	 * 游戏中计时器对象TimerObject，所有的TimerObject由GameTimer统一管理
	 * @author Tylerzhu
	 */
	public class TimerObject
	{
		
		public function TimerObject(name:String, interval:Number, repeatCount:int, callback:Function)
		{
			m_name = name;
			m_interval = interval;
			m_repeatCount = repeatCount;
			m_callback = callback;
			m_timeElapse = 0;
		}
		
		public function handler():void
		{
			//trace("[定时器]" + m_name + " time elapse: " + m_timeElapse);
			//达到指定时间间隔，执行回调函数
			if (m_interval == m_timeElapse)
			{
				//trace("[定时器]" + m_name + "执行");
				m_timeElapse = 0;
				m_currCount++;
				m_callback && m_callback(m_currCount);
			}
		}
		
		public function get timeElapse():Number
		{
			return m_timeElapse;
		}
		
		public function set timeElapse(value:Number):void
		{
			m_timeElapse = value;
		}
		
		public function get interval():Number
		{
			return m_interval;
		}
		
		public function get repeatCount():int
		{
			return m_repeatCount;
		}
		
		public function get currCount():int
		{
			return m_currCount;
		}
		
		public function get name():String
		{
			return m_name;
		}
		
		private var m_name:String; //唯一标识一个计时器对象
		private var m_interval:Number;
		private var m_repeatCount:int; //重复执行次数
		private var m_currCount:int; //当前执行次数
		private var m_callback:Function;
		private var m_timeElapse:Number; //距上次执行回调消逝的时间
	}

}