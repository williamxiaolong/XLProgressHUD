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
    
    
    @IBAction func click(sender: AnyObject) {
        
        let title = "加载中..."
        
        view.showMessage(title, interval: 1.0, position: "top")
        
    }
    
    
    @IBAction func centerClick(sender: AnyObject) {
        
        
        let title = "付款成功"
        view.showMessageAndImage(title, image: UIImage(named: "true_icon"), interval: 2.0, position: "center")
        
    }
    
    @IBAction func bottomClick(sender: AnyObject) {
        
        let title = "zhe is cut eatting fish... in work in worlkkkii inf"
        view.showTitleMessageAndImage("+134", message: title, image: UIImage(named: "true_icon"), interval: 3.0, position: "bottom")
        
    }
    
    @IBAction func activityClick(sender: AnyObject) {
        
        let title = "请求数据中..."
        view.showLoadingTilteActivity(title, position: "center")
//        view.showLoadingActivity("bottom")
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            
            print("------")
            self.view.hideActivity()
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

