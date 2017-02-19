#!/bin/sh
# 本脚本使用了 xcode 打包的相关的命令行工具，并且将打包完成后的 ipa 文件上传到 fir 上进行内部分发
xcodebuild clean -workspace  XXXX.xcworkspace -scheme XXXX -configuration Release && #项目中使用了 Cocoapod, XXXX 为对应的项目名称

xcodebuild archive -workspace XXXX.xcworkspace -scheme XXXX -configuration Release -archivePath "./XXXX.xcarchive" &&

# XXXXXXXXXX.plist 为打包相应的参数配置文件, 里面的 teamID key 的值对应到开发者账号的 teamID
# XXXXXXXXXX.plist 文件和该 sh 文件需要同时放在项目的根目录中
xcodebuild -exportArchive -archivePath "./XXXX.xcarchive" -exportPath "./XXXX" -exportOptionsPlist "XXXXXXXXXX.plist" &&

fir publish ./XXXX/XXXX.ipa -T "XXXXXXXXXXXXXXXX" &&

rm -rf ./XXXX.xcarchive &&

rm -rf ./XXXX &&

say 打包成功
