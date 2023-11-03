project_path=$(pwd)
project_last_path=${project_path%/*}

echo ""
echo "=============== 构建开始 ==============="

clean_tips="执行flutter clean(默认:n) [ y/n ]"
echo $clean_tips
read  -t 5 is_clean
if [  ! -n "${is_clean}" ];then
    is_clean="n"
fi
while([[ $is_clean != "y" ]] && [[ $is_clean != "n" ]])
do
  echo "错误!只能输入[ y/n ] ！！！"
  echo $clean_tips
  read is_clean
done

echo "请输入选择模式(默认:0) [ release: 0 , all: 1 ] "
read  -t 5 number
if [  ! -n "${number}" ];then
    number=0
fi
while([[ $number != 0 ]] && [[ $number != 1 ]])
do
  echo "错误!只能输入0或者1！！！"
  echo "请输入选择模式? [ release: 0 , all: 1 ] "
  read number
done

echo "=============== 复制Podfile配置 ==============="
cp -fr "$project_path/Podfile" "$project_last_path/Podfile"


if [ ${is_clean} = "y" ];then
  echo "=============== 开始清理 ==============="
  flutter clean
fi

echo "=============== 更新依赖 ==============="
flutter packages get
echo "=============== 依赖更新完毕 ==============="

libpath='../DemoLib/frameworks'
rm -rf "$libpath"
echo "=====移除旧的flutterLib成功====="
mkdir $libpath

echo "=============== 构建FLUTTER_IOS_FRAMEWORK ==============="
flutter build ios-framework
#cp -r build/ios/framework/Release/*.xcframework $libpath
cp -r build/ios/framework/Debug/*.xcframework $libpath
echo "=============== 复制完成 ==============="
#flutter build ios-framework --debug --no-release --no-profile --output=$libpath
#if [ $number == 0 ];then
#  flutter build ios-framework --release --no-debug --no-profile --output=$libpath
#else
#  flutter build ios-framework --output=$libpath
#fi

echo "=============== 移除编译产物 ==============="
find . -d -name build | xargs rm -rf
rm -rf build
echo "=============== 移除完成 ==============="
exit 0
