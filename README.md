/* 
  README.md
  RealmDemo

  Created by xiongan on 2017/7/26.
  Copyright © 2017年 xiongan. All rights reserved.
*/

中文版-通俗版-项目实践版 realm数据使用实践

本文总结realm数据库在iOS开发中遇到的问题以及解决办法，如果您也有遇到更多realm相关的问题请联系我andybbear@163.com

1、realm的使用介绍中文版：https://realm.io/cn/docs/objc/latest/

2、realm的优点介绍
    【转】
    跨平台：现在很多应用都是要兼顾iOS和Android两个平台同时开发。如果两个平台都能使用相同的数据库，那就不用考虑内部数据的架构不同，使用Realm提供的API，可以使数据持久化层在两个平台上无差异化的转换。

    简单易用：Core Data 和 SQLite 冗余、繁杂的知识和代码足以吓退绝大多数刚入门的开发者，而换用 Realm，则可以极大地减少学习成本，立即学会本地化存储的方法。毫不吹嘘的说，把官方最新文档完整看一遍，就完全可以上手开发了。

    可视化：Realm 还提供了一个轻量级的数据库查看工具，在Mac Appstore 可以下载“Realm Browser”这个工具，开发者可以查看数据库当中的内容，执行简单的插入和删除数据的操作。毕竟，很多时候，开发者使用数据库的理由是因为要提供一些所谓的“知识库”。
    【自我简单总结】realm使用简单，和sqlite相比不用使用sql语句，一个model就是一个张表，节省了很大的时间；但是model需要继承RLMObject对象。和CoreData相比的化简化了学习成本，毕竟我从来不用CoreData。从项目使用的角度来说，realm比较好上手，掌握基本的几个方法就能使用，支持事务，数据变化监听，数据迁移，跨平台，对于对数据库要求不高，简单来数据库做缓存的同学来说，使用简单。另一方面，realm使用也有一些坑，例如版本覆盖安装，需要进行版本迁移。pod realm 安装下载比较慢，这一点可以做成静态库放在自己的git上解决。
3、下面废话少说进入正题，show your code 。
###使用pod安装 
Podfile写法，指定使用最新版2.8.3
<code>
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'
target :RealmDemo do
pod 'Realm', '2.8.3'
end
<code/>



