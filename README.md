# iOS支付宝架构变迁之路资料
# [BeeHive](https://github.com/alibaba/BeeHive) 

BeeHive是用于iOS的App模块化编程的框架实现方案，吸收了Spring框架Service的理念来实现模块间的API耦合。
##核心
给每个模块提供生命周期事件
BeeHive会给每个模块提供生命周期事件，用于与BeeHive宿主环境进行必要信息交互，感知模块生命周期的变化。

#[mPaaS](https://github.com/rexqin)
支付宝现行架构 
更强大模块化与解耦方式式，微应用和微服务思想 

###官方介绍
mPaaS iOS 框架源自支付宝客户端的开发框架，基于 Framework 的设计思想，将业务隔离成相对独立的模块，并着力追求模块与模块之间高內聚和低耦合。

该框架直接接管应用的生命周期，负责整个应用启动托管、应用生命周期管理、处理与分发 UIApplication 的代理事件、统一管理各业务模块（微应用和服务）等。

官网已开源：

[示例代码](https://tech.antfin.com/docs/2/87472)
[文档中心](https://tech.antfin.com/docs/2/49549)


