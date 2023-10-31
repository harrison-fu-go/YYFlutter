IOS 篇：
1. 创建flutter lib 库
 flutter create --template=package hello

2. 先导出为： Flutter.xcframework， App.xcframework 动态库
   flutter clean //clean一下
   flutter packages get //更新依赖
   //flutter build ios-framework --release --no-debug --no-profile --output=$libpath 这个用于只打包release包
   flutter build ios-framework --output=$libpath //打包到指定的路径，注意：路径最好为：下面创建的xcode lib 库路径
3. 创建 Cocopods Lib 库
   pod lib create ILibrary //创建cocopods lib本地库
   设置podspec 如下：
     Pod::Spec.new do |s|
  s.name             = 'FLUTTER_LIB' //设置库名称
  s.version          = '0.1.0' //版本号
  s.summary          = 'A short description of ${POD_NAME}.' //描述
  s.description      = '详细描述'
  s.homepage         = 'https://github.com/${USER_NAME}/${POD_NAME}'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '${USER_NAME}' => '${USER_EMAIL}' }
  s.source           = { :git => 'https://github.com/${USER_NAME}/${POD_NAME}.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '10.0'
  s.source_files = 'Pod/Classes/**/*' ////这里可以放些实现协议的文件。
  s.ios.vendored_frameworks = 'frameworks/Debug/*.xcframework'   ////Debug==== 注意这里放的是上述libpath的路径下的xcframework
  #s.ios.vendored_frameworks = 'frameworks/Release/*.xcframework' ////Release==== 注意这里放的是上述libpath的路径下的xcframework
  # s.resource_bundles = {
  #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
4. 在cocopods项目中 引入第三步使用的 Cocopods Lib 即可：
   如： 
    # platform :ios, '9.0'
  target 'FlutterLibPodDemo' do
    use_frameworks!
    use_frameworks!
    pod 'FLUTTER_LIB', :path => '../DemoLib'
  end
