#!/bin/sh
#配置网络类型，测试包，线上包等
echo "Please input the package type:[local, pre, product, all]"
read inputType

INFO_PLIST_FILE_PATH='.../Info.plist' #项目的 Info.plist 文件的路径
APP_CONFIGURATION_PLIST_FILE_PATH='.../AppConfiguration.plist' #项目配置文件（比如网络环境配置）路径
FIR_TOKEN="XXXXXXX" #fir 账号 token
ARCHIVE_NAME="./XXXXXX.xcarchive"
PRE_VERSION_DIR_NAME="XXXXXXXX" #打包成功后预发包的储存路径
PRODUCT_VERSION_DIR_NAME="XXXXXXXX" #打包成功后线上包的储存路径
SPECIFIC_VERSION_DIR_NAME="XXXXXXXX" #打包成功后，包的储存路径，包的网络环境可以包括线下，预发和线上
PACKAGE_CONFIGURATION_PLIST_FILE_NAME="XXXXXXXX.plist" #打包时开发者账号配置文件名称，配置了打包的一些参数，比如开发者证书 id，打包的类型：adhoc 等

case $inputType in
    "local" )
    ;;
    "pre" )
    ;;
    "product" )
    ;;

    "all" )
    echo $infoPlistPath &&
    oldVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "$INFO_PLIST_FILE_PATH") &&
    newVersion=`expr $oldVersion + 1` &&
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $newVersion" "$INFO_PLIST_FILE_PATH" &&
    /usr/libexec/PlistBuddy -c "Set :appenv product" "$APP_CONFIGURATION_PLIST_FILE_PATH" &&
    xcodebuild clean -workspace  ********.xcworkspace -scheme ******** -configuration Release &&
    xcodebuild archive -workspace ********.xcworkspace -scheme ******** -configuration Release -archivePath "$ARCHIVE_NAME" &&
    xcodebuild -exportArchive -archivePath "$ARCHIVE_NAME" -exportPath "$PRODUCT_VERSION_DIR_NAME" -exportOptionsPlist "$PACKAGE_CONFIGURATION_PLIST_FILE_NAME" &&
    fir publish ./********/********.ipa -T "$FIR_TOKEN" &&
    rm -rf ./********.xcarchive &&
    /usr/libexec/PlistBuddy -c "Set :appenv pre" $APP_CONFIGURATION_PLIST_FILE_PATH &&
    xcodebuild clean -workspace  ********.xcworkspace -scheme ******** -configuration Release &&
    xcodebuild archive -workspace ********.xcworkspace -scheme ******** -configuration Release -archivePath "$ARCHIVE_NAME" &&
    xcodebuild -exportArchive -archivePath "$ARCHIVE_NAME" -exportPath "$PRE_VERSION_DIR_NAME" -exportOptionsPlist "$PACKAGE_CONFIGURATION_PLIST_FILE_NAME" &&
    fir publish ./********/********.ipa -T "$FIR_TOKEN" &&
    rm -rf ./********.xcarchive &&
    say 打包成功
    exit 0
    ;;

    *)
    echo "error type, type must be one of [local, pre, product, all]"
    exit -1
    ;;
esac

oldVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "$INFO_PLIST_FILE_PATH") &&
newVersion=`expr $oldVersion + 1` &&
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $newVersion" "$INFO_PLIST_FILE_PATH" &&
/usr/libexec/PlistBuddy -c "Set :appenv $inputType" "$APP_CONFIGURATION_PLIST_FILE_PATH" &&
xcodebuild clean -workspace  ********.xcworkspace -scheme ******** -configuration Release &&
xcodebuild archive -workspace ********.xcworkspace -scheme ******** -configuration Release -archivePath "$ARCHIVE_NAME" &&
xcodebuild -exportArchive -archivePath "$ARCHIVE_NAME" -exportPath "$SPECIFIC_VERSION_DIR_NAME" -exportOptionsPlist "$PACKAGE_CONFIGURATION_PLIST_FILE_NAME" &&
fir publish ./********/********.ipa -T "$FIR_TOKEN" &&
rm -rf ./********.xcarchive &&
say 打包成功
