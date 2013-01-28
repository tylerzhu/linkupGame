package com.as3game.sound
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * SoundObject - 游戏中的声音对象，可以是嵌在swf中的一段声音，也可以是外部链接的一个声音文件。
	 * @author Tylerzhu
	 */
	public class SoundObject extends EventDispatcher
	{
		
		public function SoundObject(name:String, sound:Sound)
		{
			m_name = name;
			m_sound = sound;
			
			m_playing = false;
			m_muted = false;
			m_paused = false;
		}
		
		/**
		 *生成一个新的 SoundChannel 对象来回放该声音。 此方法返回 SoundChannel 对象，访问该对象可停止声音并监控音量。
		 * （若要控制音量、平移和平衡，请访问分配给声道的 SoundTransform 对象。）
		 * @param	offset	:	Number 应开始回放的初始位置（以毫秒为单位）
		 * @param	loops	:	int 定义在声道停止回放之前，声音循环回 startTime 值的次数
		 * @param	transform	:	SoundTransform 分配给该声道的初始 SoundTransform 对象
		 * @return
		 */
		public function play(offset:Number = 0, loops:int = 0, transform:SoundTransform = null):SoundChannel
		{
			m_offset = offset;
			if (loops < 0)
			{
				m_loops = int.MAX_VALUE;
			}
			else
			{
				m_loops = loops;
			}
			
			m_channel = m_sound.play(offset, loops, transform);
			if (m_channel != null)
			{
				m_channel.addEventListener(Event.SOUND_COMPLETE, play, false, 0, true);
				m_playing = true;
				return m_channel;
			}
			
			return null;
		}
		
		/**
		 * 停止播放该声音
		 */
		public function stop():void
		{
			if (m_channel != null)
			{
				m_channel.stop();
				m_loops = 0;
				m_playing = false;
			}
		}
		
		public function get playing():Boolean
		{
			return m_playing;
		}
		
		public function get volume():Number
		{
			if (m_channel != null)
			{
				return m_channel.soundTransform.volume;
			}
			else
			{
				return 0;
			}
		}
		
		public function set volume(value:Number):void
		{
			if (m_channel != null)
			{
				var tf:SoundTransform = m_transform;
				tf.volume = value;
				m_transform = tf;
				if (!m_muted)
					m_channel.soundTransform = m_transform;
			}
		}
		
		public function get pan():Number
		{
			if (m_channel != null)
			{
				return m_channel.soundTransform.pan;
			}
			else
			{
				return 0;
			}
		}
		
		public function set pan(value:Number):void
		{
			if (m_channel != null)
			{
				var tf:SoundTransform = m_transform;
				tf.pan = value;
				m_transform = tf;
				if (!m_muted)
					m_channel.soundTransform = m_transform;
			}
		}
		
		public function get transform():SoundTransform
		{
			if (m_channel != null)
			{
				return m_channel.soundTransform;
			}
			else
			{
				return null;
			}
		}
		
		public function set transform(value:SoundTransform):void
		{
			if (m_channel != null)
			{
				m_transform = value;
				if (!m_muted)
					m_channel.soundTransform = m_transform;
			}
		}
		
		public function mute():void
		{
			if (m_channel != null)
			{
				if (m_muted)
				{
					m_channel.soundTransform = m_transform;
				}
				else
				{
					m_channel.soundTransform = new SoundTransform(0, 0);
				}
			}
			m_muted = !m_muted;
		}
		
		public function turnMuteOn():void
		{
			if (m_channel != null)
			{
				m_channel.soundTransform = new SoundTransform(0, 0);
			}
			m_muted = true;
		}
		
		public function turnMuteOff():void
		{
			if (m_channel != null)
			{
				m_channel.soundTransform = m_transform;
			}
			m_muted = false;
		}
		
		public function get isMuted():Boolean
		{
			return m_muted;
		}
		
		public function pause():void
		{
			if (m_channel != null)
			{
				if (m_paused)
				{
					var normalOffset:Number = m_offset;
					play(m_pauseTime, m_loops, m_transform);
					m_offset = normalOffset;
				}
				else
				{
					m_pauseTime = m_channel.position;
					m_channel.stop();
				}
			}
			m_paused = !m_paused;
		}
		
		public function get isPaused():Boolean
		{
			return m_paused;
		}
		
		private function complete(e:Event):void
		{
			m_channel.removeEventListener(Event.SOUND_COMPLETE, play, false);
			m_playing = false;
		}
		
		private var m_name:String;
		private var m_sound:Sound;
		private var m_channel:SoundChannel;
		private var m_transform:SoundTransform;
		private var m_playing:Boolean;
		private var m_muted:Boolean;
		private var m_paused:Boolean;
		private var m_pauseTime:Number;
		private var m_loops:uint;
		private var m_offset:Number;
	}

}