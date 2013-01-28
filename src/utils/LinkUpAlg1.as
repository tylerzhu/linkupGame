package utils
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class LinkUpAlg1
	{
		public static var path:Array;
		/**
		 * step1：是否直连（横向、纵向）
		 * step2：是否可以通过1个拐点相连
		 * step3：是否可以通过2个拐点相连
		 * @param	pointA
		 * @param	pointB
		 * @param	map
		 * @return
		 */
		public static function isLinkUp(pointA:Point, pointB:Point, map:Array):Boolean
		{
			if (pointA.x == pointB.x && pointA.y == pointB.y)
			{
				return false; //同一点
			}
			
			if (map[pointA.x + pointA.y * 10].icon != map[pointB.x + pointB.y * 10].icon)
			{
				return false; //图片icon不一样
			}
			
			path = new Array();
			mapData = map;
			return checkDirect(pointA, pointB) || checkOneCorner(pointA, pointB) || checkTwoCorner(pointA, pointB);
		}
		
		/**
		 * 检测2点是否直连：
		 * 	1. 横向直接
		 * 	2. 纵向直连
		 * @param	pointA
		 * @param	pointB
		 * @return
		 */
		private static function checkDirect(pointA:Point, pointB:Point):Boolean
		{
			//
			var pos:int;
			if (pointA.x == pointB.x) //纵向 
			{
				var minY:int = Math.min(pointA.y, pointB.y);
				var maxY:int = Math.max(pointA.y, pointB.y);
				for (var i:int = minY + 1; i < maxY; i++)
				{
					pos = pointA.x + i * 10;
					if (pos >= 0 && pos < mapData.length && !mapData[pos].flag)
					{
						return false;
					}
				}
				path.push(pointA, pointB);
				return true;
			}
			else if (pointA.y == pointB.y) //横向
			{
				var minX:int = Math.min(pointA.x, pointB.x);
				var maxX:int = Math.max(pointA.x, pointB.x);
				for (var j:int = minX + 1; j < maxX; j++)
				{
					pos = pointA.y * 10 + j;
					if (pos >= 0 && pos < mapData.length && !mapData[pos].flag)
					{
						return false;
					}
				}
				path.push(pointA, pointB);
				return true;
			}
			
			return false;
		}
		
		/**
		 * 检测2点是否可以通过1个拐点相连，这个拐点C（C点上面没有东西）满足条件之一：
		 * 	1. c.x == a.x && c.y == b.y
		 * 	2. c.y == a.y && c.x == b.x
		 * 并且AC、BC直连
		 * @param	pointA
		 * @param	pointB
		 * @return
		 */
		private static function checkOneCorner(pointA:Point, pointB:Point):Boolean
		{
			var pointC:Point;
			//检测条件一
			pointC = new Point(pointA.x, pointB.y);
			
			var idx:int;
			if (!hasBarrier(pointC) && checkDirect(pointA, pointC) && checkDirect(pointB, pointC))
			{
				idx = path.indexOf(pointB);
				(idx != -1) && path.splice(idx, 0, pointC);
				return true;
			}
			//检测条件二
			pointC = new Point(pointB.x, pointA.y);
			if (!hasBarrier(pointC) && checkDirect(pointA, pointC) && checkDirect(pointB, pointC))
			{
				idx = path.indexOf(pointB);
				(idx != -1) && path.splice(idx, 0, pointC);
				return true;
			}
			return false;
		}
		
		/**
		 * 检测2点是否可以通过2个拐点相连，拐点必定分别和a，b的横坐标或纵坐标相等。
		 * 故只需要选择一点，检验4个方向上的点是否可以与另一个点可以一个拐点相连
		 * @param	pointA
		 * @param	pointB
		 * @return
		 */
		private static function checkTwoCorner(pointA:Point, pointB:Point):Boolean
		{
			var x:int = pointA.x;
			var y:int = pointA.y;
			var point:Point;
			//向上
			while (y >= -1)
			{
				y--;
				point = new Point(x, y);
				if (hasBarrier(point))
				{
					break;
				}
				
				if (checkOneCorner(point, pointB))
				{
					path.splice(0, 0, pointA);
					return true; //找到一个拐点可以相连
				}
			}
			//向下
			y = pointA.y;
			while (y <= 5)
			{
				y++;
				point = new Point(x, y);
				if (hasBarrier(point))
				{
					break;
				}
				
				if (checkOneCorner(point, pointB))
				{
					path.splice(0, 0, pointA);
					return true; //找到一个拐点可以相连
				}
			}
			
			//向左
			x = pointA.x;
			y = pointA.y;
			while (x >= -1)
			{
				x--;
				point = new Point(x, y);
				if (hasBarrier(point))
				{
					break;
				}
				
				if (checkOneCorner(point, pointB))
				{
					path.splice(0, 0, pointA);
					return true; //找到一个拐点可以相连
				}
			}
			//向右
			x = pointA.x;
			y = pointA.y;
			while (x <= 11)
			{
				x++;
				point = new Point(x, y);
				if (hasBarrier(point))
				{
					break;
				}
				
				if (checkOneCorner(point, pointB))
				{
					path.splice(0, 0, pointA);
					return true; //找到一个拐点可以相连
				}
			}
			
			return false;
		}
		
		private static function hasBarrier(point:Point):Boolean
		{
			var i:int = point.x + point.y * 10;
			if (i < mapData.length && i >= 0)
			{
				return (!mapData[i].flag);
			}
			
			return false;
		}
		
		private static var mapData:Array;
	}

}