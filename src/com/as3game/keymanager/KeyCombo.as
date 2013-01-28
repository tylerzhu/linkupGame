package com.as3game.keymanager {
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * This class is used to represent a grouping of keys. When those keys are all pressed the COMBO_PRESSED event is fired. 
	 * COMBO_RELEASED is fired when the combination of keys are no longer pressed. 
	 * COMBO_REPEAT is fired every time the client machine says the keys are pressed again as a result of the local repeat rate.
	 */
	public class KeyCombo extends MovieClip{
		//STATIC
		static public var COMBO_PRESSED:String = "combo_pressed";
		static public var COMBO_RELEASED:String = "combo_released";
		static public var COMBO_REPEAT:String = "combo_repeat";
		//
		private var keys:Array;
		private var comboActivated:Boolean;
		/**
		 * Creates a new instance of the KeyCombo class. Use the createKeyCombo method of the KeyManager class rather than using this constructor directly.
		 */
		public function KeyCombo() {
			comboActivated = false;
			keys = new Array();
		}
		/**
		 * Adds a Key class instance to the combo. Use the createKeyCombo method of the KeyManager class to create and add keys rather than using this method directly.
		 * @param	The Key class instance.
		 */
		public function addKey(key:Key):void {
			keys.push(key);
		}
		public function getComboActivated():Boolean {
			return comboActivated;
		}
		private function analyzeState():void {
			var allDown:Boolean = true;
			for (var i:int=0;i<keys.length;++i) {
				var k:Key = keys[i];
				if (!k.getIsDown()) {
					allDown = false;
					break;
				}
			}
			if (allDown && !comboActivated) {
				comboActivated = true;
				dispatchEvent(new Event(COMBO_PRESSED));
			} else if (allDown && comboActivated) {
				dispatchEvent(new Event(COMBO_REPEAT));
			} else if (!allDown && comboActivated) {
				comboActivated = false;
				dispatchEvent(new Event(COMBO_RELEASED));
			}
		}
		/**
		 * Used by the KeyManager class to change the state of one of the keys.
		 * @param	The id of the key.
		 */
		public function keyDown(keyId:int):void {
			var stateChanged:Boolean = false;
			for (var i:int=0;i<keys.length;++i) {
				var k:Key = keys[i];
				if (k.getKeyId() == keyId) {
					k.setIsDown(true);
					stateChanged = true;
					break;
				}
			}
			if (stateChanged) {
				analyzeState();
			}
		}
		/**
		 * Use by the KeyManager class to change the state of one of the keys.
		 * @param	The id of the key.
		 */
		public function keyUp(keyId:int):void {
			var stateChanged:Boolean = false;
			for (var i:int=0;i<keys.length;++i) {
				var k:Key = keys[i];
				if (k.getKeyId() == keyId) {
					k.setIsDown(false);
					stateChanged = true;
					break;
				}
			}
			if (stateChanged) {
				analyzeState();
			}
		}
		
	}
	
}
