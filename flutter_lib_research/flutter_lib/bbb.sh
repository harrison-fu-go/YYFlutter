#前提flutter一定要是app项目: pubspec.yaml里 不要加
#module:
#  androidPackage: com.example.myflutter
#  iosBundleIdentifier: com.example.myFlutter

echo "Clean old build"
find . -d -name "build" | xargs rm -rf
flutter clean
echo "开始获取 packages 插件资源"
flutter packages get

echo "开始构建 build for ios 默认为release，debug需要到脚本改为debug"
#flutter build ios --debug
# release下放开下一行注释，注释掉上一行代码
flutter build ios --release --no-codesign
echo "构建 release 已完成"
echo "开始 处理framework和资源文件"

rm -rf build_for_ios
mkdir build_for_ios

cp -r build/ios/Release-iphoneos/*/*.framework build_for_ios
cp -r build/ios/Release-iphoneos/App.framework build_for_ios
cp -r build/ios/Release-iphoneos/Flutter.framework build_for_ios
#cp -r .ios/Flutter/engine/Flutter.xcframework build_for_ios
cp -r .ios/Flutter/FlutterPluginRegistrant/Classes/GeneratedPluginRegistrant.* build_for_ios
