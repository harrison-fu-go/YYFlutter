//参考地址： https://docs.flutter.dev/add-to-app/ios/project-setup

//设置demo的配置如下：

# platform :ios, '9.0'

# 支持源码调试开关---本地开发 请使用此模式为true， false为framework的方式
$enable_flutterDebug = false
flutter_application_path = '../flutter_lib' #flutter项目工程路径 lib项目
if $enable_flutterDebug #debug本地调试
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
end

target 'FlutterLibPodDemo' do
  use_frameworks!
  if $enable_flutterDebug #debug本地调试
    install_all_flutter_pods(flutter_application_path)
  else #framework 导入的方式
    pod 'FLUTTER_LIB', :path => '../DemoLib'
  end
end

post_install do |installer|
  if $enable_flutterDebug #debug本地调试
    flutter_post_install(installer) if defined?(flutter_post_install)
  end
end



#遇到的坑。
1. 遇到Android studio，无法Debug-> 请注意main.dart 的命名，以main_release结尾，工具认为是release模式无法debug。 
