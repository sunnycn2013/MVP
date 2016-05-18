#  基于面向协议MVP模式下的软件设计－(iOS篇)

> * 传统模式下的开发
> * MVC
> * MVVM
> * 基于面向协议MVP的介绍
> * MVP实战开发

说在前面：
	相信如果就算你是个新手也听过MVC的，MVC是构建iOS App的标准模。随着时间的推移，在iOS平台的MVC越来越面临着更多的问题,最近又开始流行MVVM,MVVM使由MVC衍生而来，MVVM用来解决一部分业务场景相关的响应式编程等，今天，本我我要介绍给大家的是一个新的方式来架构你的App: Model-View-Protocol,暂时可以理解为是基于协议的设计规范,拿出你的流行语bingo card，因为我们即将进行一次范式转变。

## 一、软件设计鼻祖MVC

### 1.1、MVC 
  
第一次听到MVC这个名词是在C#中,相信做对于MVC大家都已经很熟悉了,作为一种软件设计模式,MVC这个概念已经诞生好多年了。

如果你已经开发一段时间的iOS应用,你一定听说过Model-View-Controller,在iOS开发中Apple从一开始就给我们引入这一理念,相信这个名词大家都不陌生。

模型-视图-控制器（Model-View-Controller,MVC）是Xerox PARC在20世纪80年代为编程语言Smalltalk－80发明的一种软件设计模式,至今已广泛应用于用户交互应用程序中。在iOS开发中MVC的机制被使用的淋漓尽致,充分理解iOS的MVC模式,有助于我们程序的组织合理性。

#### Model-View-Controller

![MVC](http://ccguo.gitcafe.io/blog/2015-12-16/MVP/mvc.png) 

#### 模型对象

模型对象封装了应用程序的数据,并定义操控和处理该数据的逻辑和运算。例如,模型对象可能是表示商品数据list。用户在视图层中所进行的创建或修改数据的操作,通过控制器对象传达出去,最终会创建或更新模型对象。模型对象更改时（例如通过网络连接接收到新数据）,它通知控制器对象,控制器对象更新相应的视图对象。

#### 视图对象

视图对象是应用程序中用户可以看见的对象。视图对象知道如何将自己绘制出来,并可能对用户的操作作出响应。视图对象的主要目的,就是显示来自应用程序模型对象的数据,并使该数据可被编辑。尽管如此,在 MVC 应用程序中,视图对象通常与模型对象分离。

在iOS应用程序开发中,所有的控件、窗口等都继承自 UIView,对应MVC中的V。UIView及其子类主要负责UI的实现,而UIView所产生的事件都可以采用委托的方式,交给UIViewController实现。

#### 控制器对象

在应用程序的一个或多个视图对象和一个或多个模型对象之间,控制器对象充当媒介。控制器对象因此是同步管道程序,通过它,视图对象了解模型对象的更改,反之亦然,控制器主要负责数据的传递解耦等工作。控制器对象还可以为应用程序执行设置和协调任务,并管理其他对象的生命周期。

控制器对象解释在视图对象中进行的用户操作,并将新的或更改过的数据传达给模型对象。模型对象更改时,一个控制器对象会将新的模型数据传达给视图对象,以便视图对象可以显示它。


M和V永远不能相互通信,只能通过控制器传递。控制器可以直接与Model对话（读写调用Model）,Model通过通知或者KVO机制与控制器间接通信。控制器可以直接与View对话,通过outlet,直接操作View,outlet直接对应到View中的控件,View通过action向控制器报告事件的发生(如用户的点击事件)。控制器是View的直接数据源（数据很可能是控制器从Model中取得并经过加工了）。控制器是View的代理（delegate),以同步View与Controller。

MVC是一个用来组织代码的权威范式,也是构建iOS App的标准模式。Apple甚至是这么说的。在MVC下,所有的对象被归类为一个model,一个view,或一个controller。Model持有数据,View显示与用户交互的界面,而View Controller调解Model和View之间的交互。然而,随着模块的迭代我们越来越发现MVC自身存在着很多不足。因此,MVVM从其他应用而出,在 iOS中从此我们完全将业务逻辑加以区分并使用这套思想。
 
#### MVC在现实应用中的不足

在上图中,view将用户交互通知给控制器。view的控制器通过更新Model来反应状态的改变。Model（通常使用Key-Value-Observation）通知控制器来更新他们负责的view。大多数iOS应用程序的代码使用这种方式来组织。
 
 ##### 愈发笨重的Controller
 
 在传统的app中模型数据一半都很简单,不涉及到复杂的业务数据逻辑处理,客户端前端开发受限于他运行的的平台终端,这一点注定使移动端不像PC前端那样能够处理大量的复杂的业务场景。然而随着移动平台的各种深入,我们不的不考虑这个问题。传统的Model数据大多来源于网络数据,拿到网络数据后客户端要做的事情就是将数据直接按照顺序画在界面上。随着业务的越来越来的深入,我们依赖的service服务可能在大多时间无法第一时间满足客户端需要的数据需求,移动端愈发的要自行处理一部分逻辑计算操作。这个时间一惯的做法是在控制器中处理,最终导致了控制器成了垃圾箱,越来越不可维护。
 
 控制器Controller是app的“胶水代码”：协调模型和视图之间的所有交互。控制器负责管理他们所拥有的视图的视图层次结构,还要响应视图的loading、appearing、disappearing等等,同时往往也会充满我们不愿暴露的Model的模型逻辑以及不愿暴露给视图的业务逻辑。这引出了第一个关于MVC的问题...
 
视图view通常是UIKit控件（component,这里根据习惯译为控件）或者编码定义的UIKit控件的集合。进入.xib或者Storyboard会发现一个app、Button、Label都是由这些可视化的和可交互的控件组成。你懂的。View不应该直接引用Model,并且仅仅通过IBAction事件引用controller。业务逻辑很明显不归入view,视图本身没有任何业务。
 
 厚重的View Controller由于大量的代码被放进viewcontroller,导致他们变的相当臃肿。在iOS中有的view controller里绵延成千上万行代码的事并不是前所未见的。这些超重app的突出情况包括：厚重的View Controller很难维护（由于其庞大的规模）；包含几十个属性,使他们的状态难以管理；遵循许多协议（protocol）,导致协议的响应代码和controller的逻辑代码混淆在一起。

厚重的view controller很难测试,不管是手动测试或是使用单元测试,因为有太多可能的状态。将代码分解成更小的多个模块通常是件好事。
 
##### 太过于轻量级的Model

太过于轻量级的Model,早期的Model层,其实就是如果数据有几个属性,就定义几个属性,ARC普及以后我们在Model层的实现文件中基本上看不到代码( 无需再手动管理释放变量,Model既没有复杂的业务处理,也没有对象的构造,基本上.m文件中的代码普遍是空的)；同时与控制器的代码越来厚重形成强烈的反差,这一度让人不禁对现有的开发设计构思有所怀疑。
 
##### 遗失的网络逻辑

苹果使用的MVC的定义是这么说的：所有的对象都可以被归类为一个Model,一个view,或是一个控制器。就这些。那么把网络代码放哪里？和一个API通信的代码应该放在哪儿？
你可能试着把它放在Model对象里,但是也会很棘手,因为网络调用应该使用异步,这样如果一个网络请求比持有它的Model生命周期更长,事情将变的复杂。显然也不应该把网络代码放在view里,因此只剩下控制器了。这同样是个坏主意,因为这加剧了厚重控制器的问题。
 
那么应该放在那里呢？显然MVC的3大组件根本没有适合放这些代码的地方。
 
##### 较差的可测试性
MVC的另一个大问题是,它不鼓励开发人员编写单元测试。由于控制器混合了视图处理逻辑和业务逻辑,分离这些成分的单元测试成了一个艰巨的任务。大多数人选择忽略这个任务,那就是不做任何测试。
 
上文提到了控制器可以管理视图的层次结构；控制器有一个“view”属性,并且可以通过IBOutlet访问视图的任何子视图。当有很多outlet时这样做不易于扩展,在某种意义上,最好不要使用子视图控制器（child view controller）来帮助管理子视图。
  
在这里有多个模糊的标准,似乎没有人能完全达成一致。貌似无论如何,view和对应的controller都紧紧的耦合在一起,总之,还是会把它们当成一个组件来对待。Apple提供的这个组件一度以来在某种程度误导了大多初学者,初学者将所有的视图全部拖到xib中,连接大量的IBoutLet输出口属性,都是一些列问题。

### 二、大剑之初MVVM

在经历了一大堆吐槽之后,诞生了MVVM(一个高大尚牛逼哄哄的名词,从此又多了一种人,你懂MVVM ？如果你的回答是否,瞬间被鄙视一把)。

新思维

其实MVVM据说最早在微软的.NET平台中出现过(具体什么背景,什么原因就不一一介绍了,还是要感谢伟大的.NET平台工程师,造剑不如造经,世间万道皆不离其宗),无论是是MVVM还是MVC我们无需坚持反对或者迷恋于它。在MVVM中他的设计思路和MVC很像。它正式规范了视图和控制器紧耦合的性质,并引入新的组件。
  
Model-View-ViewModel
在理想的世界里,MVC也许工作的很好。然而,我们生活在真实的世界。既然我们已经详细说明了MVC在典型场景中的问题,那让我们看一看一个可供替换的选择：Model-View-ViewModel。

在MVVM里,view和view controller正式联系在一起,我们把它们视为一个组件。视图view仍然不能直接引用模型Model,当然controller也不能。相反,他们引用视图模型view Model。
 
view Model是一个放置用户输入验证逻辑,视图显示逻辑,发起网络请求和其他各种各样的代码的极好的地方。有一件事情不应归入view Model,那就是任何视图本身的引用。view Model的概念同时适用于于iOS和OS X。（换句话说,不要在view Model中使用 #import UIKit.h）
 
由于展示逻辑（presentation logic）放在了view Model中（比如Model的值映射到一个格式化的字符串）,视图控制器本身就会不再臃肿。当你开始使用MVVM的最好方式是,可以先将一小部分逻辑放入视图模型,然后当你逐渐习惯于使用这个范式的时候再迁移更多的逻辑到视图模型中。
 
以我的经验,使用MVVM会轻微的增加代码量,但总体上减少了代码的复杂性。这是一个划算的交易。
 
回过头再来看MVVM的图示,你会注意到我使用了模糊的动词“notify”和“update”,而没有详细说明该怎么做。你可以使用KVO,就像MVC那样,但这很快就会变得难以管理。事实上,使用[ReactiveCocoa](http://www.teehanlax.com/blog/getting-started-with-reactivecocoa/)会是更好的方式来组织各个部分。
 
关于怎么结合ReactiveCocoa来使用MVVM的信息,可以阅读开源[app](https://github.com/AshFurrow/C-41)。你也可以阅读我的关于[ReactiveCocoa和MVVM](https://leanpub.com/iosfrp)的书。

关于MVVM的具体细节此处就不多详细介绍,此处重在做对比分析,如果了解的可以去了解相关资料。
  
## 三、基于面向协议MVP的介绍

&nbsp;&nbsp;&nbsp;&nbsp;曾经有无数个人总喜欢问我你们的iOS采用什么样的架构,其实每次被问到这样的问题,不是瞬间被萌了,就是想自己问自己iOS也有架构？？

&nbsp;&nbsp;&nbsp;&nbsp;上文提到了MVC、MVVM,真实的业务场景中,如果场景的逻辑异常复杂,在反复的迭代中仍会出现各式各样的问题。真对MVVM我个人理解主要是将原来Controller中处理数据逻辑的代码统一归到一个新的class(viewModel)中去,更甚之网络请求等工作全部从Controller移到viewModel。刚一开始总觉的怪怪的。现阶段客户端开发越来越进入一个2.0的阶段,早期的app功能都相对比较简单,无论是从界面还是从业务逻辑上给人的感觉都是简洁实用,这中间包括UI的设计、功能的设计、产品的设计定位等。随着行业的深入,用户的过渡依赖移动端最终导致业各式各样的业务更加依赖客户端,这就导致客户端的开发不得不向PC端靠齐,在版本的反复迭代中业务场景变的愈发不尽人意,仿佛又回到了软件设计的早期。

&nbsp;&nbsp;&nbsp;&nbsp;在传统软件领域,从MVC的诞生主要是为了解决软件界面的行为的分离,在复杂的业务场景内会进一步区分业务逻辑场景的分离,这些手段的最终的目的都是尽最大限度的降低整个场景的藕合度,使其达到分离的目的,模块与模块最终得到独立,将整个场景化整为零,最终使每个模块在一个零上工作,这对于无论是软件的开发还是后续的维护、以及使用普遍遵循这个原则,现有的模式大概产生了相关的类似架构。

传统web架构里面是这样解决的 : 

![service](http://ccguo.gitcafe.io/blog/2015-12-16/MVP/service.png) 


* web段以及其他业务层负责从接口层获取数据并执行自己的逻辑
* service层为外部提供接口
* DTO从负责从DB链接并进行数据读写操作
* DB层(物理机负责数据存储)

现有客户度一度采用下面的模式:

![MVC](http://ccguo.gitcafe.io/blog/2015-12-16/MVP/ios_mvc.png) 

&nbsp;&nbsp;&nbsp;&nbsp;客户端通过service拿到json 数据,然后通过MVC的结构展示到UI界面上,在iOS中一直流行MVC的开发模式,通过与传统开发模式对比可以发现,其实
service层－客户端交互与服务端service服务满足外部业务场景无非是两个互逆的过程(一个输出层,一个输入层,都是为了更好的满足的下一步的业务需求,一个是将原始数据逻辑话,一个是将获得逻辑数据存档并且展示到用户面前)。service层根据具体的业务场景提供对应的数据服务,service根据不同的业务场景通过DTO层拿到对应
的数据然后组织好数据提供给外界(service 层负责将原始物理数据转换成对应的逻辑数据提供给外界)。

&nbsp;&nbsp;&nbsp;&nbsp;相反,客户端通过网络层拿到对应的网络数据绘制到对应的View上,但是实际的开发过程中,网络数据与真实客户端使用场景也是有一定的差距,MVVM层将对应的
一部分逻辑处理移植到了ViewModel中,这并没有从根本上解决问题,无非是将代码做了一份对应的copy转移,并没有从根本上达到逻辑分层的概念。相反MVP模
式恰好解决了这一难题,MVP模式衍生于传统service架构,针对不同的业务场景图供对应的匹配的抽象service服务,客户端拿到网络数据后未达到指定的目的,
为满足相同抽象逻辑的业务场景,在客户端网络层与Model层之间加一协议层,Model层实现整个协议层,之后在基于MVC的结构下将一概相同层次的
业务场景绘制解释到对应的View上。

![MVP](http://ccguo.gitcafe.io/blog/2015-12-16/MVP/mvp.png) 

* M : 逻辑Model层
* V : 视图层
* P : protocol协议层

Model层类似于MVVM的ViewModel,主要负责存储抽象逻辑数据,另外Model层主还有部分工作实现对应的协议层协议,提供协议对应的各种属性以及服务。Model经过协议层抽象约束,最后Model被抽象成具有统一抽象逻辑的业务场景,最终Model层在讲数据交付整个MVC结构绘制展示的时间,我们可以按照同一套抽象的逻辑标准去执行。

在传统的web层面,为了满足各式各样的业务逻辑场景服务,最红我们实现软件罗杰的层次的分离,诞生了service服务这个概念(service就类似一个标准尺寸的水龙头出口,只要对应的水龙头都按照这样的规则来生产,service就能够满足格式各样的业务场景,极大的解决的传统软件服务业务场景层次的一系列难题)；相同的原理在客户端同样可以使用,为了满足客户端MVC结构层里面的稳定,避免各式各样的业务场景迭代插入不同的逻辑,避免最终软件危机的产生,我们采用追加协议层的模式来满足这一目的。

遍观整个软件开发,从早期的软件开发,到后来软件生产管理的危机,软件开发模式一步步的确立,软件行业的每个阶段都是一个里程碑。这世间没有相对完美独到的设计法则,但是亘古不变永远只有一个那就是软件的开发更佳面相生产化、规范化、更加的利于可维护化。一直以来我本人并不特别的注重软件的设计一定、必须按照某种规则来做,毕竟不同的人、不同的业务场景、不同的工程师总有不同的实际境况,站在一个开发工程师的角度来说我并不固执于都按照固定的规则来(比如说你必须按照某个模式来做,必须用MVVM来做；必须用ReactCocoa信号型机制来做...)。相反我个人认为太过于固执只不过某些人的一厢情愿的罢了。相反我觉得因地制宜、应运而生岂不更加快哉,设计不拘于模式,更多时间更是不局限于思考。无论是MVVM、MVP哪一个不是脱胎于MVC,这个世间万变不离其宗,万千功法始终都离不开一部最终的母经。


## 四、MVP实战开发

说了这么多,下面上实战例子。

大概描述一下业务场景,作为电商app,我们希望在原生的基础上开发一套定制的可控、可配、可维护的通用型原生模版(至于说的这么灵活 有多么的好,为啥不用H5、ReactNative,这个问题不要来问我,产品狗们让做原生,程序员只能执行)。大概是这样一个场景,可以配置的楼层样式多达十几种(至少目前已经有十几种,以后可能会更多)；每种可配置楼层样式是多元的,外观长相不一,数据格式也不尽相同但有部分类同；要求后台CMS配置界面配置法则有共同相似之处；要求每种样式楼层处理事件记忆跳转不尽相同；最可恨的页面已经很长了以后会源源不断加入新的模版。
考虑到长远,这样的复杂楼层,如果仍旧按照传统的模式来做,问题会很多,数据无法统一、无法统一绘制、无法统一处理。具体场景相信大家应该理解了。

上设计思路

潜在问题

* server段需要针对不同的楼层场景下发不同的数据 数据结构不尽相同
* 模版楼层样式不尽相同 可能对应多种View
* 多种View与多种数据结构的解释解耦问题
* 多种业务场景用户操作逻辑处理问题
* 楼层过于复杂 Controller代码大爆炸

逻辑建模分析

* 暂时可以将每种模版楼层的整体数据作为一个容器Modle,主要负责该楼层的整体数据调度  

* 将每种楼层公有的属性以及内容抽象出来放入一个容器父类Container,然后将不同模版特有的属性放在子模版派生Model中,作为派生属性

* 对准一个容器类,我可以将每种容器Model的使用法则抽象总结归纳(1、楼层是否有Header,是否要吸顶；2、该楼层具体要由什么样的View模版去绘制; 3、楼层内容是绘制在单个section单个cell中还是绘制在多行上; 4、每个楼层的元素点击跳转处理等). 我们将容器这块作为一个数据源概念最终抽象出一套可供外界获取数据的Interface(Protocol)

* 当我们拿到楼层数据后在父容器基础上做子楼层的派生,我们要求派生容器去实现上述父容器的Protocol,通过协议我们可以知道具体的绘制的目标,以及要绘制的元素个数等,最终达到一个目的,
 将每个楼层的数据装配在我们定义好的一个适配器容器内,然后通过协议给外界提供一套统一的操作入口,之后我们才用统一的操作方式操作容器,最终实现一个容器对应一个楼层。
 
* Render 协议,在这个我们对准每个要具体绘制到UI上的Model,我们统一让其实现Render协议,通过适配器容器我们我们拿到具体要绘制的目标,
 目标绘制题都实现了Render协议,在Render协议我们可以拿到具体当前Model将由哪个具体的Cell去呈递。在每个绘制目标题内由Model决定
 当前内容由什么样式的cell模版去绘制。我们把所有的楼层数据处理逻辑压在适配器容器内,再将Model的绘制目标都交由Model自己决定。

* 实现上述目标后,在ViewController层面,我们看到的只有一个实现了适配器协议的Model数组,在 table的绘制过程我们通过操作一个
 id<适配器Protocol> 类型的Model对象, 拿到这个具体的索引对应的对象后,通过内部已经实现的协议我们很快的拿到下一个要绘制的目标Model
 然后再拿到具体的Cell模版的Identifier,然后从tableview中取到当前Identifier对应的cell模版,传入数据最后返回一个cell。
 
 这个地方我们先定义了一个适配容器协议,以及一个父容器类,我们将楼层公有属性放在父类中,将派生容器子类(具体的楼层Model)实现一个抽象协议。

MVP模式的原则是，在service层提供一大堆不尽相同的业务场景之后，我们将这一系列数据全部抽象归纳，通过定制一套标准的protocol协议，让不同业务场景的都去实现这一协议，最终将数据全部装配、拼装成一套具有相同调度规则的统一编制话数据Model，之后我们采用id<protocol>的标准去操作数据。

MVP除了将数据逻辑完全镇封的各自的Model,同时将那些Model需要绘制，哪些Model需要校验, 哪些Model需要接受处理点击Action这些逻辑全部由Model自己来决定，Controller只作为一个粘合性的模版，Controller只处理一批具有共性的范型类数据，至于具体的操作操作毫不关心。

MVP面相的更多的是在MVC上层与service之间追加了一层协议层，我们认为通过协议层处理过的数据是暂时可以客户端场景使用的数据，在数据到达MVC我们针对数据进行再加工、再构造处理，这一切全部在容器内操作。这一点完全与别的设计模式相反。

MVP并不是让用户在Model打上网络请求操作、在Model层执行[self.navigationController pushViewController:***]等这些操作，其实相对大多人来说对于部分对象生命周期长短问题还是很在乎，所以在处理TemplateActionProtocol协议的时间，MVP只是对准Action做了一层抽象封装。通过实现TemplateActionProtocol的Model会产生一个Action对象，最终通过block的调用链传回控制器中,我们在控制器中统一做handler处理。

MVP我们最初设计目的就是为了强调一个装配概念，如果发生了业务场景的追加,控制器我不会改动其中的代码，只需要将新数据追加成相同批次的ViewModel，然后配置进容器，之后控制器不做任何修改就可以满足需求了。通过具体的剥离、抽取我们成功了的最大限度的剥离了控制器，满足了轻量级Controller这一概念。

MVP与传统软件相比,在设计这一点的时间我们完全借鉴了传统软件的思维模式，Java平台的service设计模式、三层架构这些设计规范都相对做了一些对比分析，最终得出了MVP这一理念。

分析场景完毕,下面来分析一个模版的例子来说命一切吧！！
### Protocol 设计

Template 协议

* 	－TemplateRenderProtocol   		//任何一个具体绘制到cell上的Model都需要实现该协议
* 	－TemplateSorbRenderProtocol   //楼层的header如果要吸顶需要使用该协议替代基本的Render协议
* 	－TemplateActionProtocol	    //具有Action 操作的Model需要实现,返回一个通用的Action对象
* 	－TemplateCellProtocol			//整个体系中所有的Cell统一实现该协议
* 	- TemplateValidationProtocol   //- 处理一部分认证校验数据

ViewController
*	- 楼层显示统一交与Model层定制
*	- VC中生成ActionModel,跳转逻辑全部应用于Action协议层,ViewController实现ActionManager 代理,作为回调处理
*	- 特定属性处理逻辑放在分类内
*	- 网络层调用扔保持在ViewController,这一点与传统保持相似,有利于结构分明(优于市面上的所谓MVVM)


```
//TemplateRenderProtocol.h
@protocol TemplateRenderProtocol <NSObject,TemplateActionProtocol>
@required
- (NSString *)floorIdentifier;

@end

//TemplateSorbRenderProtocol.h
@protocol TemplateSorbRenderProtocol <NSObject>

- (NSString *)headerFloorIdentifier;
- (id <TemplateSorbRenderProtocol>)headerFloorModelAtIndex:(NSInteger)index;

@end


//TemplateActionProtocol.h
 */
@protocol TemplateActionProtocol <NSObject>

@optional

- (TemplateAction *)jumpFloorModelAtIndexPath:(NSIndexPath *)indexPath;

@end


//TemplateCellProtocol.h
@protocol TemplateBaseProtocol;

typedef void (^TapBlock) (NSIndexPath* index);

@protocol TemplateCellProtocol <NSObject>

@optional
+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size;

- (void)processData:(id <TemplateRenderProtocol>)data;

- (void)tapOnePlace:(TapBlock) block;

@end

```


### Model设计

```
//  TemplateContainerModel.h

/**
 *  容器概念
 */
@protocol TemplateContainerProtocol <NSObject>

@required

- (NSInteger)numberOfChildModelsInContainer;

- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index;

@end

@class TemplateChannelModel;
@interface TemplateContainerModel : NSObject<TemplateContainerProtocol,TemplateActionProtocol,TemplateRenderProtocol>

//netList
@property (nonatomic,strong) NSNumber                 *identityId;
@property (nonatomic,strong) NSString                 *pattern;
@property (nonatomic,strong) TemplateFHeaderModel     *fheader;
@property (nonatomic,strong) NSArray                  *itemList;
@property (nonatomic,strong) TemplateJumpModel        *jump;
@property (nonatomic,strong) TemplateMarginModel      *margin;
//other add
@property (nonatomic,assign) TemplateChannelModel     *channelModel;
@end

```

下面的就先引用一个具体的业务场景吧,顶部banner楼层,每个大的楼层都是一个容器Model,是继承于父容器,并且会适当重写父类协议以及方法

```
//TemplateFloorFocusModel.h

//此处,banner是多个对象绘制成轮播的样式,整体是绘制在同一个cell上的,所以TemplateFloorFocusModel首先是一个容器类,是具有数据源的
功能,但是他又是一个绘制目标Model,TemplateFloorFocusModel实现了Render协议,就决定这个接下来会将TemplateFloorFocusModel绘制到UI界面上(如果此处的容器存储的是一个section下的list形式,容器类就无需实现render协议,只需要将list 中的Model实现render协议即可)

@interface TemplateFloorFocusModel : TemplateContainerModel<TemplateRenderProtocol>

@property (nonatomic,assign) NSNumber *width;
@property (nonatomic,assign) NSNumber *height;

@end


//TemplateFloorFocusModel.m

@implementation TemplateFloorFocusModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"itemList" : @"picList"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList" : @"TemplatePicModel"
             };
}

//pragma mark - TemplateContainerProtocol

- (NSInteger)numberOfChildModelsInContainer
{
    NSUInteger rows = 0;
    if (self.margin) rows++;
    if (self.itemList) rows++;
    return rows;
}

//(如果此处的容器存储的是一个section下的list形式,此处返回一个实现render协议的Model即可)
- (id <TemplateRenderProtocol>)childFloorModelAtIndex:(NSInteger)index
{
    if ((self.margin)&&(index+1) == [self numberOfChildModelsInContainer])
        return self.margin;  //最后一行
    return self;
}

//pragma mark - TemplateActionProtocol

- (TemplateAction *)jumpFloorModelAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger position = [indexPath indexAtPosition:0];
    if (position < self.itemList.count) {
        
        TemplatePicModel *picModel = self.itemList[position];
        TemplateJumpAction *action = [[TemplateJumpAction alloc] init];
        action.jumpToType = TemplateJumpToActivityM;
        action.jumpToUrl = picModel.jump.url;
        action.eventId = @"GeneralChannel_BannerPic";
        return action;
    }
    return nil;
}

//pragma mark -  TemplateRenderProtocol
- (NSString *)floorIdentifier
{
    return @"TemplateFocusCell";
}

```


### View 设计

View设计此处我们才用方式依旧是将Cell作为模版,将对应的视图逻辑统一放在一个UIViewSubView中, 之后在Cell中将View直接add到cell.ContentView上。

针对焦点图cell TemplateFocusCell我们有一个TemplateFocusView来对应,下面看下代码设计

TemplateFocusCell

```
// TemplateFocusCell
@interface TemplateFocusCell : UITableViewCell<TemplateCellProtocol>

@end

@interface TemplateFocusCell (){
    TemplateFocusView *_focusView;
}

@property (nonatomic,strong) id <TemplateRenderProtocol> data;

@end
@implementation TemplateFocusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _focusView = [[TemplateFocusView alloc] init];
        _focusView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_focusView];
       }
    return self;
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    if([data isKindOfClass:[TemplateFloorFocusModel class]])
    {
        self.data = data;
        [_focusView processData:(id <TemplateRenderProtocol>)data];
    }
}

+ (CGSize)calculateSizeWithData:(id<NSObject>)data constrainedToSize:(CGSize)size
{
//    id<TemplateRenderProtocol> model = data;
    CGSize curSize = CGSizeMake(ScreenWidth, 110);
    return curSize;
}
- (void)tapOnePlace:(TapBlock) block
{
    [_focusView setTapBlock:block];
}

```

TemplateFocusView 

```

@interface TemplateFocusView : UIView<TemplateCellProtocol>

@end

@interface TemplateFocusView ()<iCarouselDataSource,iCarouselDelegate>
{
    UIPageControl *_pageControl;
    iCarousel     *_scrollView;
}

@property (nonatomic,strong) TemplateFloorFocusModel *focusModel;
@end

@implementation TemplateFocusView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _scrollView = [[iCarousel alloc] init];
        _scrollView.delegate = self;
        _scrollView.dataSource = self;
        _scrollView.type = iCarouselTypeLinear;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounceDistance = 0.5;
        _scrollView.decelerationRate = 0.5;
        _scrollView.clipsToBounds = YES;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_pageControl];
            
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self).insets(UIEdgeInsetsZero);
        }];
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.mas_equalTo(@(5));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

+ (CGSize)calculateSizeWithData:(id<TemplateRenderProtocol>)data constrainedToSize:(CGSize)size
{
    return size;
}

- (void)processData:(id <TemplateRenderProtocol>)data
{
    self.focusModel = (TemplateFloorFocusModel *)data;
    _pageControl.numberOfPages = self.focusModel.itemList.count;
    [_scrollView reloadData];
    
    [self layoutIfNeeded];
}

//pragma mark -
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _focusModel.itemList.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (!view) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth/2)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        }else{
        imageView = (UIImageView *)view;
    }
   
    TemplatePicModel *model = self.focusModel.itemList[index];
    [imageView setImageWithURL:[NSURL URLWithString:model.img]];
    return imageView;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap)
    {
        return YES;
    }
    return value;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    NSInteger index = _scrollView.scrollOffset;
    
    [_pageControl setCurrentPage:index];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    if (_tapBlock) {
        _tapBlock(indexPath);
    }
}


```


从View层可以看到,我们仍旧遵循以往的模式,将cell高度的计算,最终放在View中来完成(此处我们并没有Model化,而是仍旧遵循大家的习惯,具体的高度根据具体的视图场景来控制),看到此处的计算高度的方法,接下来的问题就不多说了....


###  Controller 设计

在做完以上的一些列的逻辑化抽象工作以后,从新回到控制器层面,此时应该是大松了一口气了,到目前为止,我们一大堆系列的工作都已经做完了,只是还有一点失望的感觉是暂时还没看到是否真的有卵用,这就好比十年铸一剑,继而十年在磨一剑,看不到成效始终觉得心中似有亏欠。

到目前为止,我们在控制器层面能做的仅有的是范型数据的操作,已经安全没有逻辑了,逻辑全部压入了Model,下面就看下控制器层面的逻辑：

```
//处理action
- (TapBlock)tapBlockForModel:(id<TemplateRenderProtocol>)model
{
    __weak typeof (self) weakself = self;
    return ^(NSIndexPath * indexPath){
        if ([model conformsToProtocol:@protocol(TemplateActionProtocol)]) {
            TemplateAction *action = [(id<TemplateActionProtocol>)model jumpFloorModelAtIndexPath:indexPath];
            [weakself.handler handlerAction:action];
        }
    };
}

//注册cell

[self.tableView registerClass:[TemplateFocusCell class] forCellReuseIdentifier:@"TemplateFocusCell"];


//tableView 代理实现
//pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.floorModel.floors count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TemplateContainerModel<TemplateContainerProtocol> *list = self.floorModel.floors[section];
    return [list numberOfChildModelsInContainer];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <TemplateRenderProtocol> model = [self.floorModel rowModelAtIndexPath:indexPath];
    UITableViewCell <TemplateCellProtocol> * cell = [tableView dequeueReusableCellWithIdentifier:[model floorIdentifier]];
    [cell processData:model];
    [cell tapOnePlace:[self tapBlockForModel:model]];
    if(!cell){
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }else{
        return (UITableViewCell *)cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id <TemplateRenderProtocol>  floor = [self.floorModel rowModelAtIndexPath:indexPath];
    if ([floor respondsToSelector:@selector(floorIdentifier)]) {
        NSString *cellIdentifier = [floor floorIdentifier];
        Class<TemplateCellProtocol> viewClass = NSClassFromString(cellIdentifier);
        CGSize size = [viewClass calculateSizeWithData:floor constrainedToSize:CGSizeMake(tableView.frame.size.width, 0.0)];
        return size.height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id <TemplateSorbRenderProtocol,TemplateRenderProtocol> floor = self.floorModel.floors[section];
    if ([floor conformsToProtocol:@protocol(TemplateSorbRenderProtocol)]) {
        NSString *headerIdentifier = [floor headerFloorIdentifier];
        if (headerIdentifier) {
            Class<TemplateCellProtocol> viewClass = NSClassFromString(headerIdentifier);
            CGSize size = [viewClass calculateSizeWithData:floor constrainedToSize:CGSizeMake(tableView.frame.size.width, 0.0)];
            return size.height;
        }
    }

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id <TemplateSorbRenderProtocol,TemplateRenderProtocol> floor = self.floorModel.floors[section];
    if ([floor conformsToProtocol:@protocol(TemplateSorbRenderProtocol)]) {
        id<TemplateSorbRenderProtocol> headerModel = [floor headerFloorModelAtIndex:section];
        if (headerModel) {
            NSString *identifier = [headerModel headerFloorIdentifier];
            UIView <TemplateCellProtocol> *headerView = (UIView <TemplateCellProtocol> *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
            [headerView processData:floor];
            return headerView;
        }
    }
    return nil;
}


```

 至此,控制器只剩下以上操作,相对来说已经最大限度的梳理了逻辑,将所有的逻辑压入Model,如果服务端新增了新型的业务场景的数据,依旧可以通过协议层的适配,将数据最终的组装上述模式,最后直接拿来使用,如果需要修改对应的View,直接可以在Model内修改具体的将要渲染的View的名字即可,这些工作都跟控制器层没有任何关系。
 
 在Action协议中,具有Action操作的Model会在使用过程中实现TemplateActionProtocol这一协议,在事件处理的时间会抛出这样一个ActionModel,之后此处我们会直接对Action对象handler操作,此处并没有控制器层UI界面的操作,这一点遵循了设计模式中的命令行模式(这一点原理脱胎于于strus框架中XWork框架,将控制器与UI工作无关的内务以命令行的模式跑出来,放在别的一个代理中去完成,这样能够最大的限度的做到对控制器层面的瘦身工作)。
 
 说到控制器瘦身工作,iOS常用的大概是就是Category了,将部分全局型属性、逻辑放在对应的分类里面,有助于逻辑的抽离、代码的分割。
 
 [MVPDemo](https://github.com/sunnyvalue/MVP.git)


容器模式 适配器模式 命令行模式

[MVVM](https://leanpub.com/iosfrp)

[说说Android的MVP模式](http://toughcoder.net/blog/2015/11/29/understanding-android-mvp-pattern/)

[用Model-View-ViewModel构建iOS App](http://www.cocoachina.com/ios/20140716/9152.html)

[浅谈iOS中MVVM的架构设计与团队协作](http://www.cocoachina.com/ios/20150122/10987.html)

[Model-View-Controller](http://developer.apple.com/library/ios/documentation/general/conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html#//apple_ref/doc/uid/TP40010810-CH14-SW1)