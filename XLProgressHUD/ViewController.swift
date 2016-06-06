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
        
        let title = "修改成功"
        
        view.showMessage(title, interval: 1.0, position: "top")
        
    }
    
    // 提示显示在视图中部
    @IBAction func centerClick(sender: AnyObject) {
        
        
        let title = "修改成功"
        view.showMessageAndImage(title, image: UIImage(named: "true_icon"), interval: 1.0, position: "center")
        
    }
    
    // 提示显示在视图底部
    @IBAction func bottomClick(sender: AnyObject) {
        
        let title = "恭喜你！\n答对了"
        view.showTitleMessageAndImage("+2", message: title, image: UIImage(named: "coins_big_icon"), interval: 1.0, position: "bottom")
        
    }
    
    // 网络数据请求中
    @IBAction func activityClick(sender: AnyObject) {
        
        let title = "加载中..."
        view.showLoadingTilteActivity(title, position: "center")
        
        // 模拟网络数据加载设置的显示时间
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
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

