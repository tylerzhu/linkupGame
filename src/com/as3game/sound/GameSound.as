package com.as3game.sound
{
	import com.as3game.asset.AssetManager;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	/**
	 * 游戏声音管理类：管理游戏中的背景音乐、按钮等点击声效
	 * 声音的播放，即将Sound.play()方法赋值给SoundChannel实例就可以开始播放歌曲了。
	 *
	 * 游戏中声音有2两种：
	 *         1. 背景音乐：循环播放一直存在
	 *         2. 按钮音效等：点击才触发，这种声音任何时候只播放一个，如果两个瞬间点击多个按钮，只播放最后一个声音
	 * @author Tylerzhu
	 */
	public class GameSound
	{
		public static function getInstance():GameSound
		{
			if (!m_instance)
			{
				m_instance = new GameSound(new PrivateClass());
			}
			return m_instance;
		}
		
		/**
		 *
		 * @param	name	:	String
		 * @param	offset	:	Number 应开始回放的初始位置（以毫秒为单位）
		 * @param	loops	:	int 定义在声道停止回放之前，声音循环回 startTime 值的次数
		 * @param	transform	:	SoundTransform 分配给该声道的初始 SoundTransform 对象
		 * @param	applicationDomain
		 * @return
		 */
		public function playSound(name:String, offset:Number = 0, loops:int = 0, //
			transform:SoundTransform = null, applicationDomain:ApplicationDomain = null):SoundChannel
		{
			var channel:SoundChannel = null;
			if (!m_soundDic[name])
			{
				//声音不存在，创建声音对象SoundObject
				var sound:Sound;
				var soundCls:Class;
				try
				{
					soundCls = (applicationDomain != null) ? applicationDomain.getDefinition(name) as Class : getDefinitionByName(name) as Class;
				}
				catch (err:ReferenceError)
				{
					trace("找不到" + name + "指定的声音对象，尝试加载外部文件。");
				}
				
				if (soundCls)
				{
					sound = new soundCls() as Sound;
					m_soundDic[name] = new SoundObject(name, sound);
					channel = m_soundDic[name].play(offset, loops, transform);
				}
				else
				{
					AssetManager.getInstance().getAsset(name, function():void
						{
							sound = AssetManager.getInstance().bulkLoader.getSound(name);
							m_soundDic[name] = new SoundObject(name, sound);
							channel = m_soundDic[name].play(offset, loops, transform);
						});
				}
			}
			else
			{
				channel = m_soundDic[name].play(offset, loops, transform);
			}
			
			return channel;
		}
		
		/**
		 * 停止播放name指定声音
		 * @param	name
		 */
		public function stopSound(name:String = null):void
		{
			if (name)
			{
				if (m_soundDic[name])
				{
					m_soundDic[name].stop();
				}
				else
				{
					trace("sound " + name + "不存在");
				}
			}
			else
			{
				for each (var item:SoundObject in m_soundDic)
				{
					item.stop();
				}
			}
		}
		
		/**
		 * 设置name指定声音的大小
		 * @param	value
		 * @param	name
		 */
		public function setVolume(value:Number, name:String = null):void
		{
			if (name)
			{
				if (m_soundDic[name])
				{
					m_soundDic[name].volume = Math.max(0, Math.min(1, value));
				}
				else
				{
					trace("sound " + name + "不存在");
				}
			}
			else
			{
				for each (var item:SoundObject in m_soundDic)
				{
					item.volume = Math.max(0, Math.min(1, value));
				}
			}
		}
		
		/**
		 * 获取name指定声音的音量大小
		 * @param	name
		 * @return
		 */
		public function getVolume(name:String):Number
		{
			if (m_soundDic[name])
			{
				return m_soundDic[name].volume;
			}
			else
			{
				throw new Error("Sound " + name + " 不存在");
			}
			return 0;
		}
		
		/**
		 * 获取声音播放的声道
		 * @param	name
		 * @return
		 */
		public function getChannel(name:String):SoundChannel
		{
			if (m_soundDic[name])
			{
				return m_soundDic[name].channel;
			}
			else
			{
				throw new Error("Sound " + name + " does not exist.");
			}
			return null;
		}
		
		/**
		 * 对name指定声音设置静音或取消静音：
		 * 	1. 当前为静音，则取消静音
		 *  2. 当前为有声，则设置静音
		 * 如果name为空，这对引擎中所有声音进行设置
		 * @param	name	String	
		 */
		public function mute(name:String = null):void
		{
			if (name)
			{
				if (m_soundDic[name])
				{
					m_soundDic[name].mute();
					if (!m_soundDic[name].isMuted)
						m_allMuted = false;
				}
				else
				{
					throw new Error("Sound " + name + " does not exist.");
				}
			}
			else
			{
				m_allMuted = !m_allMuted;
				if (m_allMuted)
				{
					for each (var i:SoundObject in m_soundDic)
					{
						i.turnMuteOn();
					}
				}
				else
				{
					for each (var j:SoundObject in m_soundDic)
					{
						j.turnMuteOff();
					}
				}
			}
		}
		
		/**
		 * 打开所有声音
		 */
		public function turnAllSoundsOn():void
		{
			if (m_allMuted)
			{
				mute();
			}
		}
		
		/**
		 * 对所有声音设置静音
		 */
		public function turnAllSoundsOff():void
		{
			if (!m_allMuted)
			{
				mute();
			}
		}
		
		/**
		 * 对name指定声音暂停或继续播放
		 *  1. 当前暂停，则继续播放
		 *  2. 当前播放，则暂停播放
		 * name为空则对引擎中所有声音进行设置
		 * @param	name	String	
		 */
		public function pauseSound(name:String = null):void
		{
			if (name)
			{
				if (m_soundDic[name])
				{
					m_soundDic[name].pause();
				}
				else
				{
					throw new Error("Sound " + name + " does not exist.");
				}
			}
			else
			{
				for each (var i:String in m_soundDic)
					m_soundDic[i].pause();
			}
		}
		
		/**
		 * 返回name指定声音是否正在播放
		 * 如果name为空或这声音不存在，返回false
		 * 如果声音只是暂停播放，也是返回true！！！
		 * @param	name	String		
		 * @return			Boolean		
		 */
		public function isPlaying(name:String):Boolean
		{
			if (m_soundDic[name])
			{
				return m_soundDic[name].playing;
			}
			else
			{
				trace("Sound " + name + " does not exist.");
			}
			return false;
		}
		
		/**
		 * 返回name指定声音是否暂停状态
		 * @param	name	String		
		 * @return			Boolean		
		 */
		public function isPaused(name:String):Boolean
		{
			if (m_soundDic[name])
			{
				return m_soundDic[name].isPaused;
			}
			else
			{
				throw new Error("Sound " + name + " does not exist.");
			}
			return false;
		}
		
		/**
		 * 返回name指定声音是否静音状态
		 * @param	name	String		
		 * @return			Boolean		
		 */
		public function isMuted(name:String = null):Boolean
		{
			if (name)
			{
				if (m_soundDic[name])
				{
					return m_soundDic[name].isMuted;
				}
				else
				{
					throw new Error("Sound " + name + " does not exist.");
				}
				return false;
			}
			else
			{
				return m_allMuted;
			}
			return true;
		}
		
		/**
		 * 销毁引擎单例，停止所有声音等
		 * @param null
		 * @return void
		 */
		public function dispose():void
		{
			// 停止所有声音
			m_instance.stopSound();
			
			// 把所有声音对象置空
			for (var i:String in m_soundDic)
			{
				m_soundDic[i] = null;
			}
			
			// 清空引擎管理的声音字典
			m_soundDic = null;
			
			// 单例置空
			m_instance = null;
		
		}
		
		public function GameSound(pvt:PrivateClass)
		{
			if (m_instance)
			{
				throw new Error("GameSound is a Singleton class. Use getInstance() to retrieve the existing instance.");
			}
			
			m_soundDic = new Dictionary(true);
			m_allMuted = false;
		}
		
		private static var m_instance:GameSound; //实例对象
		
		private var m_soundDic:Dictionary;
		private var m_allMuted:Boolean;
	}

}

class PrivateClass
{
	public function PrivateClass()
	{
		//trace("包外类，用于实现单例");
	}
}