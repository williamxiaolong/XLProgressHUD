//
//  ViewController.swift
//  XLProgressHUD
//
//  Created by yuanxiaolong on 16/6/1.
//  Copyright © 2016年 yuanxiaolong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 
    }
    
    // 提示显示在视图顶部
    @IBAction func click(sender: AnyObject) {
        
        let message = "修改成功"
        view.showMessage(message, interval: 0.2, position: "top")
        
    }
    
    // 提示显示在视图中部
    @IBAction func centerClick(sender: AnyObject) {
        
        
        let message = "修改成功"
        view.showMessageAndImage(message, image: UIImage(named: "true_icon"), interval: 0.2, position: "center")
        
    }
    
    // 提示显示在视图底部
    @IBAction func bottomClick(sender: AnyObject) {
        
        let title = "+2"
        let message = "恭喜你！\n答对了"
        view.showTitleMessageAndImage(title, message: message, image: UIImage(named: "coins_big_icon"), interval: 0.2, position: "bottom")
        
    }
    
    // 网络数据请求中
    @IBAction func activityClick(sender: AnyObject) {
        
        let message = "加载中..."
        view.showLoadingTilteActivity(message, position: "center")
        
        // 模拟网络数据加载设置的显示时间
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            
            // 隐藏提示视图
            self.view.hideActivity()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

