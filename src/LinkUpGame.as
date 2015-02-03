<?xml version="1.0" encoding="utf-8"?>
<s:WindowedApplication xmlns:fx="http://ns.adobe.com/mxml/2009" 
					   xmlns:s="library://ns.adobe.com/flex/spark" 
					   xmlns:mx="library://ns.adobe.com/flex/mx"
					    width="600"
						 height="800"
					   addedToStage="LinkUpGameStart()">
	<fx:Declarations>
		<!-- 将非可视元素（例如服务、值对象）放在此处 -->
	</fx:Declarations>
	<fx:Script>
		<![CDATA[
			/**
			 * 基于PureMVC框架的"连连看"游戏，通过该实例你可以学习到：
			 * 	1. PureMVC框架的使用
			 *  2. 推荐的PureMVC项目目录结构
			 *  3. “连连看”游戏的算法设计
			 * @author
			 */
			import com.as3game.utils.StageUtil;
			
			import flash.display.Sprite;
			import flash.events.Event;
			
			import framework.ApplicationFacade;			
			
			//整个程序ui容器
			public var containerSprite:Sprite;
			
			public function LinkUpGameStart():void
			{
				if (stage)
				{
					init();
				}
				else
				{
					addEventListener(Event.ADDED_TO_STAGE, init);
				}
			}
			
			private function init(e:Event = null):void
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
				StageUtil.stage = stage;
				containerSprite = new Sprite();
			//	this.addChild(contenterSprite);
				this.containerVisual.addChild(containerSprite);
				//初始化PureMVC框架，并启动游戏
				ApplicationFacade.getInstance().startUp(containerSprite);
			}
		]]>		
	</fx:Script>
	
	<s:SpriteVisualElement id="containerVisual" />
</s:WindowedApplication>
