XLProgressHUD
======
Function Demonstration
-----
![](https://github.com/williamxiaolong/XLProgressHUD/blob/master/DemonstrationImages/demonstrated-icon.gif)

CocoaPods
----
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:

        $ gem install cocoapods
        
To integrate XLProgressHUD into your Xcode project using CocoaPods, specify it in your 'Podfile' :

        source 'https://github.com/CocoaPods/Specs.git'
        platform :ios, '8.0'
        use_frameworks!
        
        target '<Your Target Name>' do
            pod 'XLProgressHUD', '~> 1.0.5'
        end
        
Then, run the following command:

        $ pod install

Usage
----
#### Introduce

        import XLProgressHUD

#### Use Code
1、单独内容信息提示

        let message = "修改成功"
        view.showMessage(message, interval: 0.2, position: "top")
2、内容信息 ＋ 图片 提示

        let message = "修改成功"
        view.showMessageAndImage(message, image: UIImage(named: "true_icon"), interval: 0.2, position: "center")
3、标题信息 ＋ 内容信息 ＋ 图片 提示

        let title = "+2"
        let message = "恭喜你！\n答对了"
        view.showTitleMessageAndImage(title, message: message, image: UIImage(named: "coins_big_icon"), interval: 0.2, position: "bottom")
4、网络请求持久显示提示

        let message = "加载中..."
        view.showLoadingTilteActivity(message, position: "center")
        // 模拟网络数据加载设置的显示时间
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            
            // 隐藏提示视图
            self.view.hideActivity()
        }

##### Parameter description

        title: 显示提示框上部的文字参数
        message: 显示提示下部的文字提示框
        image: 显示提示框里面的图片参数
        interval: 显示提示框显示时间的参数
        position: 显示提示框显示位置 使用填入参数为（"top"  "center"  "bottom"） 默认为nil时现在在中部位置

