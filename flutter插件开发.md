参考链接： https://doc.flutterchina.club/developing-packages/
Demo: 使用flutter_engine_groups 下的demo为例子

Package 介绍
使用package可以创建可轻松共享的模块化代码。一个最小的package包括

一个pubspec.yaml文件：声明了package的名称、版本、作者等的元数据文件。

一个 lib 文件夹：包括包中公开的(public)代码，最少应有一个<package-name>.dart文件

Package 类型
Packages可以包含多种内容：

Dart包：其中一些可能包含Flutter的特定功能，因此对Flutter框架具有依赖性，仅将其用于Flutter，例如fluro包。

插件包：一种专用的Dart包，其中包含用Dart代码编写的API，以及针对Android（使用Java或Kotlin）和/或针对iOS（使用ObjC或Swift）平台的特定实现。一个具体的例子是battery插件包。

步骤： 

一. 开发纯的Dart插件
Step 1: 创建flutter create --template=package XXXXX
lib/XXXXX.dart:
Package的Dart代码

Step 2: 实现package
对于纯Dart包，只需在主lib/XXXXX.dart文件内或lib目录中的文件中添加功能 。

Step 3: 引用方式， 在主项目下的pubspec.yaml中的 dev_dependencies 添加。 如下例子
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  XXXXX:
    path: ./lib_modules/XXXXX

二. 开发包含 安卓&iOS&Flutter的插件包。

Step 1 创建：
flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -a kotlin hello 
flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -a java hello
flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -i objc hello
flutter create --org com.example --template=plugin --platforms=android,ios,linux,macos,windows -i swift hello

//指定安卓或者ios下的开发语言
flutter create --template=plugin --platforms=android,ios -i objc hello
flutter create --template=plugin --platforms=android,ios -a java hello

//创建demo
flutter create --org com.fuhuayou --template=plugin --platforms=android,ios -a kotlin native_demo (这句话基本OKay.)
flutter create --template=plugin --platforms=android,ios -i swift native_demo


Step 2 实现：

直接使用 MehodChannel/Pogeon 的方式调用Native 的代码
新的插件，IOS 执行 pod install 后，自动引入到Pods/Development的文件夹下。
Andriod : ... 


Step 3: 引用方式， 在主项目下的pubspec.yaml中的 dev_dependencies 添加。 如下例子， 和纯dart插件包无区别。
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  XXXXX:
    path: ./lib_modules/XXXXX




