package com.as3game.keymanager {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * This class is used to manage KeyCombo classes, which make it easy to capture when a combination of keys has been pressed, release, or is repeating.
	 * This class must be added to the stage in order to capture keyboard events. Add it to the root scope if you can since keyboard events start at a focused movie clip and bubble up.
	 * @example
	 * This example shows how to capture COMBO_PRESSED, COMBO_RELEASED, and COMBO_REPEAT events for the key combo that contains A, S, and SPACE.
	 * <listing>
	 * private var KM:KeyManager;
		private function testKeyManager():void {
			KM = new KeyManager();
			addChild(KM);
			//
			var kc:KeyCombo = KM.createKeyCombo(Key.A, Key.S, Key.SPACE);
			//
			kc.addEventListener(KeyCombo.COMBO_PRESSED, comboPressed);
			kc.addEventListener(KeyCombo.COMBO_RELEASED, comboReleased);
			kc.addEventListener(KeyCombo.COMBO_REPEAT, comboRepeat);
		}
		private function comboRepeat(e:Event):void {
			trace("combo repeat");
		}
		private function comboPressed(e:Event):void {
			trace("combo pressed");
		}
		private function comboReleased(e:Event):void {
			trace("combo released");
		}
	 * </listing>
	 */
	public class KeyManager extends MovieClip {
		static public const ALPHA_NUMERIC_KEY_DOWN:String = "alpha_numeric_key_down";
		
		private var combos:Array;
		private var onStage:Boolean;
		/**
		 * Creates a new instance of the KeyManager class.
		 */
		public function KeyManager() {
			onStage = false;
			combos = new Array();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		/**
		 * Creates a new KeyCombo class instance and populates it with the keys passed in. 
		 * @param	Pass in as many keys as you want using the key code for that key. Most keys have convenient references in the Key class, such as Key.SPACE, Key.A, Key.B, etc.
		 * @return The instance of the KeyCombo class.
		 */
		public function createKeyCombo(...keys):KeyCombo {
			var kc:KeyCombo = new KeyCombo();
			for (var i:int=0;i<keys.length;++i) {
				var k:Key = new Key(keys[i]);
				kc.addKey(k);
			}
			combos.push(kc);
			return kc;
		}
		/**
		 * Removes a KeyCombo class so it is no longer used.
		 * @param	The KeyCombo class to remove.
		 */
		public function removeKeyCombo(kc:KeyCombo):void {
			for (var i:int=0;i<combos.length;++i) {
				if (combos[i] == kc) {
					combos.splice(i, 1);
					break;
				}
			}
		}
		/**
		 * @private
		 * Register the stage event listeners.
		 * @param	The event.
		 */
		private function addedToStage(e:Event):void {
			if (!onStage) {
				onStage = true;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
			
		}
		/**
		 * @private
		 * Remove stage event listeners
		 * @param	The event.
		 */
		private function removedFromStage(e:Event):void {
			if (onStage) {
				onStage = false;
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
		}
		/**
		 * The KeyboardEvent triggered by the Flash player.
		 * @param	KeyboardEvent
		 */
		private function keyDown(e:KeyboardEvent):void {
			for (var i:int=0;i<combos.length;++i) {
				var kc:KeyCombo = combos[i];
				kc.keyDown(e.keyCode);
			}
			//dispatchEvent(new Event("s|a"));
		}
		/**
		 * The KeyboardEvent triggered by the Flash player.
		 * @param	KeyboardEvent
		 */
		private function keyUp(e:KeyboardEvent):void {
			for (var i:int=0;i<combos.length;++i) {
				var kc:KeyCombo = combos[i];
				kc.keyUp(e.keyCode);
			}
			//dispatchEvent(new Event("s|a"));
		}
		
		
	}
	
}
