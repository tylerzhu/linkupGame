package com.as3game.utils
{
	import flash.utils.Dictionary;
	
	/**
	 * 随机类
	 */
	public final class RandomUtil
	{
		private static var randomHistory:Dictionary = new Dictionary(); //随机数历史记录
		
		/**
		 * 获得一个范围内的双精度小数
		 *
		 * @param min	最小值
		 * @param max	最大值
		 * @param duplicate	是否可重复
		 * @return
		 */
		public static function dec(min:Number, max:Number, duplicate:Boolean = true):Number
		{
			var r:Number;
			r = min + Math.random() * (max - min);
			if (!duplicate)
			{
				while (randomHistory[r])
					r = min + Math.random() * (max - min);
				
				randomHistory[r] = true;
			}
			
			return r;
		}
		
		/**
		 * 获得一个范围内的有符号整数
		 *
		 * @param min	最小值
		 * @param max	最大值
		 * @param duplicate	是否可重复
		 * @return
		 */
		public static function integer(min:int, max:int, duplicate:Boolean = true):int
		{
			var r:int;
			r = min + Math.random() * (max - min);
			if (!duplicate)
			{
				while (randomHistory[r])
					r = min + Math.random() * (max - min);
				
				randomHistory[r] = true;
			}
			
			return r;
		}
		
		/**
		 * 清除随机数历史记录。重新开始取数。
		 */
		public static function clearHistory():void
		{
			for (var key:*in randomHistory)
			{
				delete randomHistory[key];
			}
		}
		
		/**
		 * 生成固定长度的随机字符串
		 *
		 * @param len	长度
		 * @return
		 */
		public static function string(len:int):String
		{
			var result:String = "";
			for (var i:int = 0; i < len; i++)
			{
				result += String.fromCharCode(integer(65, 122));
			}
			return result;
		}
		
		/**
		 * 随机排序
		 * @param arr	数组
		 */
		public static function randomArray(arr:Array):Array
		{
			return arr.sort(randomFunction);
		}
		
		private static function randomFunction(n1:*, n2:*):int
		{
			return (Math.random() < 0.5) ? -1 : 1;
		}
		
		/**
		 * 随机选择多个数
		 * @param arr
		 * @param num
		 * @return
		 */
		public static function chooseMuti(arr:Array, num:int):Array
		{
			var a:Array = randomArray(arr.concat());
			return a.slice(0, num);
		}
		
		/**
		 * 以均等的几率从多个参数中选择一个
		 *
		 * @param reg	数组
		 * @return
		 */
		public static function choose(... reg):*
		{
			return reg[int(Math.random() * reg.length)];
		}
		
		/**
		 * 随机切分数字，生成一个数组。这个数组的总和等于原数字。
		 * 用于生成满足约束的随机数列。
		 *
		 * @param amount	总和
		 * @param n	数量，必须为2的N次方
		 * @return
		 */
		public static function randomSeparate(amount:Number, n:int):Array
		{
			var a:int = Math.log(n) / Math.LN2;
			var arr:Array = [amount];
			while (a > 0)
			{
				var newArr:Array = [];
				for (var i:int = 0; i < arr.length; i++)
				{
					var v1:Number = Math.random() * arr[i];
					var v2:Number = arr[i] - v1;
					newArr.push(v1, v2);
				}
				arr = newArr;
				
				a--;
			}
			return arr;
		}
		
		/**
		 * 另一种切分数字的方式，对数量无限制
		 * @param amount
		 * @param n
		 * @return
		 */
		public static function randomSeparate2(amount:Number, n:int):Array
		{
			var r:Array = [];
			var c:Number = 0;
			for (var i:int = 0; i < n; i++)
			{
				var v:Number = Math.random();
				r.push(v);
				c += v;
			}
			
			for (i = 0; i < n; i++)
				r[i] = r[i] * amount / c;
			
			return r;
		}
	
	}
}