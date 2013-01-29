linkupGame【基于PureMVC实现的连连看小游戏】
==========
todo：

1. 游戏已知bug修复
2. 增加连连看其它算法方式

下面的说明参考完整的博客文章[PureMVC（AS3）剖析：实例](http://www.cnblogs.com/skynet/archive/2013/01/29/2881244.html) 

首先声明“连连看”游戏并非很适合使用PureMVC框架，因为它本身并不复杂，而且没有需要复用的逻辑代码等。这里通过这样一个不太复杂的小游戏，介绍PureMVC。
1. 需求
----------

《连连看》是一款操作非常简单的小游戏，它的玩法就是用直线将两个相同的图标消掉，分为十关，难度递进。

【概要】玩家可以将 2 个相同图案的对子连接起来，连接线不多于 3 根直线，就可以成功将对子消除。

【操作】第一次使用鼠标点击棋盘中的棋子，该棋子此时为“被选中”，以特殊方式显示；再次以鼠标点击其他棋子，若该棋子与被选中的棋子图案相同，且把第一个棋子到第二个棋子连起来，中间的直线不超过 3 根，则消掉这一对棋子，否则第一颗棋子恢复成未被选中状态，而第二颗棋子变成被选中状态

2. 设计
----------

整个游戏分为2个模块：关卡选择模块、关卡具体模块。关卡选择模块，类似一个菜单呈现10个关卡供玩家选择；关卡具体模块，呈现特定关卡的详细信息，如需要消除的棋子、总时间、重排棋子按钮、获取提示按钮、暂停按钮等等。

关卡数据的几点说明：

 1. 关卡数据可以通过关卡编辑器生成配置文件，然后读取配置文件即可。这样关卡更可控，且可以摆放成各种形状（心形、回形等等）的数据。
 2. 如果做成网络版的，关卡数据也可以通过服务器端返回。
 3. 本实例为了简单，关卡数据根据等级随机生成10种图片，数量固定为40个。

关卡难度递进设定：

1. 第一，从时间递减来增加难度，30 * (11 - level)。
2. 第二，从可以重新摆放棋子、获取提示次数来体现。
3. 如果作为一个商用连连看，还可以通过棋子的种类数量、定时随机重排增加难度。

判断连通算法，可以使用多种：分支界定判断、广度优先搜索法、四个方向的A*算法等等，例子不考虑性能简单的使用了分支界定判断，而且这里也不会深入介绍，毕竟我的目的不是介绍连连看算法，有兴趣的自行了解。
3. 实现
----------
我们做技术的，看代码就可以了解如何使用PureMVC了，更推荐你去看代码。下面我只介绍代码的几个PureMVC实现的关键地方。

【注意点1】：PureMVC框架初始化流程，及代码组织

这也是我想推送给大家的，框架初始化流程可参见【2. 推荐PureMVC初始化流程】，代码组织方法可参见【3. 推荐PureMVC结构】。

【注意点2】：模块划分与通信

游戏分为2个模块：关卡选择模块、关卡具体模块。

	关卡选择模块包括：

framework.view.componets.ChooseLevCanvasMediator

framework.view.componets.ui.ChooseLevCanvas

framework.controller.commands.ChooseLevCommand

该模块不用存储数据，没有Proxy。

ChooseLevCanvas、ChooseLevCanvasMediator组成View，ChooseLevCanvas负责具体UI展示和操作响应，ChooseLevCanvasMediator负责将来自用户操作的事件转发给PureMVC框架并将来自框架的事件转发给ChooseLevCanvas。

ChooseLevCommand由玩家选择具体关卡事件ApplicationConstants.SELECT_LEVEL触发，该Command调用LevelProxy的接口生成关卡数据，然后通知到“关卡具体模块”开始游戏。

	关卡具体模块包括：

framework.view.componets.LevelCanvasMediator

framework.view.componets.ui.LevelCanvas

framework.model.LevelProxy

framework.controller.commands.ReSortCommand

LevelProxy 属于Model，生成、存储、重排具体关卡的数据，负责数据相关操作。

LevelCanvas与LevelCanvasMediator组成View，LevelCanvas负责具体UI展示和响应玩家操作，LevelCanvasMediator负责将来自用户操作的事件转发给PureMVC框架并将来自框架的事件转发给LevelCanvas。

ReSortCommand由玩家点击重排按钮触发，该Command调用LevelProxy的接口重排关卡中的棋子。

这里涉及到的通信方式有，通知、flash内置事件（xxxCanva与xxxCanvasMediator）。

1. Command需要侦听通知，需要在framework.controller.boostraps.BootstrapCommands中使用registerCommand注册；
2. xxxCanvasMediator需要侦听通知，需要在对应Mediator中使用listNotificationInterests注册，并重写handleNotification处理。

模块间通信可参见【4.PureMVC模块见通信】。

【注意点3】：Command与Proxy、Mediator

Command管理应用程序的 Business Logic（业务逻辑），要协调Model 与视图状态。

Model 通过使用 Proxy 来保证数据的完整性、一致性 。Proxy 集中程序的Domain Logic（域逻辑），并对外公布操作数据对象的API。它封装了所有对数据模型的操作，不管数据是客户端还是服务器端的。

Mediator 和Proxy 可以提供一些操作接口让Command 调用来管理View Component 和Data Object ，同时对 Command隐藏具体操作的细节。

【注意点4】：一般一个Mediator（handleNotification方法）处理的Notification应该在4、5个之内。

还要注意的是，Mediator的职责应该要细分。如果处理的Notification很多，则意味着Mediator需要被拆分，在拆分后的子模块的Mediator里处理要比全部放在一起更好。

【注意点5】：应该避免Mediator与Proxy 直接交互。

例子项目中遵从了这个规则，但实际上项目Mediator中不可避免需要获取Proxy数据，如果每次都通过一个Notification去获取数据，然后返回数据给Mediator，这样无形中增加了通信次数、带反馈数据的通信加重通信负担。所以可以适当是的在Mediator中facade.retrieveProxy获取Proxy然后拿到数据，而且从proxy直接拿数据，可以保证拿到最新数据。