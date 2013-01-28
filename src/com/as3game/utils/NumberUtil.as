package com.as3game.utils
{
	
	/**
	 * 数值Numer相关的功用接口
	 */
	public class NumberUtil
	{
		
		/**
		 * 将度数转换为弧度
		 * @param	度数
		 * @return	弧度
		 */
		static public function degreesToRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}
		
		/**
		 * 将弧度转换为度数
		 * @param	弧度
		 * @return	度数
		 */
		static public function radiansToDegrees(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		/**
		 * 将度数转换为0~360之间的值
		 * @param	度数
		 * @return	0~360之间的对应值
		 */
		static public function clampDegrees(degrees:Number):Number
		{
			var result:Number = degrees % 360;
			return (degrees < 0) ? result + 360 : result;
		}
		
		/**
		 * 将弧度转换为0~2*Math.PI之间的值
		 * @param	弧度
		 * @return
		 */
		static public function clampRadians(radians:Number):Number
		{
			var result:Number = radians % (2 * Math.PI);
			return (radians < 0) ? result + 2 * Math.PI : result;
		}
		
		/**
		 * 判断角度angle是否夹在angle1、angle2之间
		 * @param	angle
		 * @param	angle1
		 * @param	angle2
		 * @return
		 */
		static public function isAngleBetween(angle:Number, angle1:Number, angle2:Number):Boolean
		{
			var isBetween:Boolean;
			angle = clampDegrees(angle);
			angle1 = clampDegrees(angle1);
			angle2 = clampDegrees(angle2);
			
			isBetween = (angle >= angle1) && (angle <= angle2);
			if (angle1 > 180 && angle2 < 180)
			{
				//？？？
				if (angle <= 360 && angle >= angle1)
				{
					isBetween = true;
				}
				if (angle >= 0 && angle <= angle2)
				{
					isBetween = true;
				}
			}
			
			return isBetween;
		}
	
	}

}
