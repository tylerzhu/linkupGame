package com.as3game.keymanager
{
	
	/**
	 * 键盘上按键类
	 */
	public class Key
	{
		public function Key(keyId:int)
		{
			this.keyId = keyId;
			setIsDown(false);
		}
		
		public function setIsDown(isDown:Boolean):void
		{
			this.isDown = isDown;
		}
		
		public function getIsDown():Boolean
		{
			return isDown;
		}
		
		public function getKeyId():int
		{
			return keyId;
		}
		//STATIC
		static public var A:int = 65;
		static public var B:int = 66;
		static public var C:int = 67;
		static public var D:int = 68;
		static public var E:int = 69;
		static public var F:int = 70;
		static public var G:int = 71;
		static public var H:int = 72;
		static public var I:int = 73;
		static public var J:int = 74;
		static public var K:int = 75;
		static public var L:int = 76;
		static public var M:int = 77;
		static public var N:int = 78;
		static public var O:int = 79;
		static public var P:int = 80;
		static public var Q:int = 81;
		static public var R:int = 82;
		static public var S:int = 83;
		static public var T:int = 84;
		static public var U:int = 85;
		static public var V:int = 86;
		static public var W:int = 87;
		static public var X:int = 88;
		static public var Y:int = 89;
		static public var Z:int = 90;
		//
		static public var NUMBER_0:int = 48;
		static public var NUMBER_1:int = 49;
		static public var NUMBER_2:int = 50;
		static public var NUMBER_3:int = 51;
		static public var NUMBER_4:int = 52;
		static public var NUMBER_5:int = 53;
		static public var NUMBER_6:int = 54;
		static public var NUMBER_7:int = 55;
		static public var NUMBER_8:int = 56;
		static public var NUMBER_9:int = 57;
		//
		static public var SHIFT:int = 16;
		static public var CONTROL:int = 17;
		static public var SPACE:int = 32;
		static public var ENTER:int = 13;
		static public var TAB:int = 9;
		//
		static public var LEFT:int = 37;
		static public var UP:int = 38;
		static public var RIGHT:int = 39;
		static public var DOWN:int = 40;
		//
		private var keyId:int;
		private var isDown:Boolean;
	
	}

}
