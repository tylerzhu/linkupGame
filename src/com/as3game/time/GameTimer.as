package com.as3game.time
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class GameTimer
	{
		
		static public function getInstance():GameTimer
		{
			if (m_instance == null)
			{
				m_instance = new GameTimer(new PrivateClass());
			}
			return m_instance;
		}
		
		public function destroy():void
		{
			
			if (m_timer != null)
			{
				m_timer.stop();
				m_timer.removeEventListener(TimerEvent.TIMER, onTimerManager, false);
			}
			
			m_instance = null;
			m_timerDic = null;
			m_timer = null;
		}
		
		/**
		 * 注册定时器
		 * @param	name
		 * @param	interval
		 * @param	repeatCount
		 * @param	callback
		 */
		public function register(name:String, interval:Number, repeatCount:int, callback:Function):void
		{
			if (m_timerDic[name] == null)
			{
				m_timerDic[name] = new TimerObject(name, interval, repeatCount, callback);
				if (!m_timer.running)
				{
					m_timer.start();
				}
			}
			else
			{
				trace("定时器：" + name + " 已经存在，无需重复注册");
			}
		}
		
		/**
		 * 注销定时器
		 * @param	name
		 */
		public function unregister(name:String):void
		{
			delete m_timerDic[name];
			
			if (timerNum == 0)
			{
				m_timer.stop();
			}
		}
		
				
		public function get interval():int 
		{
			return m_interval;
		}
		
		public function set interval(value:int):void 
		{
			m_interval = value;
		}
		
		public function GameTimer(pvt:PrivateClass)
		{
			if (m_instance != null)
			{
				throw new Error("GameTimer is a Singleton class. Use getInstance() to retrieve the existing instance.");
			}
			
			m_timerDic = new Dictionary(true);
			m_timer = new Timer(m_interval);
			m_timer.addEventListener(TimerEvent.TIMER, onTimerManager, false, 0, true);
		}
		
		private function onTimerManager(e:TimerEvent):void
		{
			for each (var timer:TimerObject in m_timerDic)
			{
				timer.timeElapse += m_interval;
				timer.handler();
				
				if (timer.repeatCount != 0 && timer.currCount == timer.repeatCount)
				{
					//定时器任务完成，注销定时器
					unregister(timer.name);
				}
			}
		}
		
		private function get timerNum():uint
		{
			var num:uint = 0;
			for each (var timer:TimerObject in m_timerDic)
			{
				num++;
			}
			return num;
		}
		
		static private var m_instance:GameTimer;
		private var m_timer:Timer;
		private var m_timerDic:Dictionary;
		
		private var m_interval:int = 100; //100ms
	}

}

class PrivateClass
{
	public function PrivateClass()
	{
		//trace("包外类，用于实现单例");
	}
}