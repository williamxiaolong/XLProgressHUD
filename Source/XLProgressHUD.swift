//
//  XLProgressHUD.swift
//  XLProgressHUD
//
//  Created by yuanxiaolong on 16/6/1.
//  Copyright © 2016年 yuanxiaolong. All rights reserved.
//
import UIKit
import Foundation

// 总体
let proportionWidth:CGFloat     = 0.8     //80%的占比宽度
let proportionHeight:CGFloat    = 0.8     //80%的占比高度
let horizontalPadding:CGFloat   = 10.0
let verticalPadding:CGFloat     = 10.0
let cornerRadius:CGFloat        = 10.0
let opacity:CGFloat             = 0.7
let titleFontSize:CGFloat       = 16.0
let messageFontSize:CGFloat     = 16.0
let titleLines                  = 0
let messageLines                = 0
let fadeDuration:Double         = 0.2

let defaultPosition             = "center"


// 阴影
let shadowOpacity:Float         = 0.8
let shadowRadius:CGFloat        = 5.0
let shadowOffset                = CGSize(width: CGFloat(4.0), height: CGFloat(4.0))
var displayShadow               = true

// 图片
let imageViewWidth:CGFloat      = 20.0
let imageViewHeight:CGFloat     = 20.0
let bigImageViewWidth:CGFloat   = 30.0
let bigImageViewHeight:CGFloat  = 30.0

// 一直显示的View
let activityViewWidth:CGFloat   = 120
let activityViewHeight:CGFloat  = 100
let activityOpactity:CGFloat    = 0.7
var activityViewKey             = "activityViewKey"
let activityFontSize:CGFloat    = 14.0


extension UIView{
    
    // 只含有提示信息的提示
    public func showMessage(message:String?,interval:CGFloat,position:AnyObject){
        
        if let view = viewForMessage(nil, message: message, image: nil) {
            
            showView(view, interval: interval, point: position)
        }
        
    }
    
    
    // 含有提示信息和图片的提示
    public func showMessageAndImage(message:String?,image:UIImage?,interval:CGFloat,position:AnyObject){
        
        if let view = viewForMessage(nil, message: message, image: image) {
            
            showView(view, interval: interval, point: position)
        }
        
        
    }
    
    // 含有标题、信息和图片的提示
    public func showTitleMessageAndImage(title:String?,message:String?,image:UIImage?,interval:CGFloat,position:AnyObject){
        
        if let view = viewForMessage(title, message: message, image: image) {
            
            showView(view, interval: interval, point: position)
        }
        
    }
    
    // 含有提示信息的加载提示
    public func showLoadingTilteActivity(message:String,position:AnyObject?){
        
        activityView(message, position: position)
        
    }
    
    // 没有提示信息的加载提示
    public func showLoadingActivity(position:AnyObject?){
        
        activityView(nil, position: position)
        
    }
    
    // 隐藏提示
    public func hideActivity(){
        
        hideActivityView()
        
    }
    
    // 控件显示（控件显示停留时间与动画）
    private func showView(view:UIView,interval:CGFloat,point:AnyObject){
        
        view.center = centerPointForPositon(view, point: point)
        view.alpha = 0.0
        addSubview(view)
        userInteractionEnabled = false
        
        UIView.animateWithDuration(fadeDuration,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations: {
                                     view.alpha = 1.0
            }) { (finished) in
                
                UIView.animateWithDuration(fadeDuration,
                                           delay: Double(interval),
                                           options: UIViewAnimationOptions.CurveEaseIn,
                                           animations: {
                                            view.alpha = 0.0
                    }, completion: { (finished) in
                        view.removeFromSuperview()
                        self.userInteractionEnabled = true
                })
                
        }
        
    }
    
    // 设置控件位置
    private func centerPointForPositon(view:UIView,point:AnyObject?) -> CGPoint{
        
        if point is String {
            
            let pointStr = point as! String
            if pointStr == "top" {
                
                return CGPoint(x: bounds.size.width * 0.5, y: view.bounds.size.height * 0.5 + verticalPadding)
            }else if pointStr == "bottom" {
                
                return CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height - view.bounds.size.height * 0.5 - verticalPadding - 40)
                
            }else{
                
                return CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
            }
            
        }else if point is NSValue{
            
            return point!.CGPointValue()
        }else{
            
            return centerPointForPositon(view, point: defaultPosition)
        }
        
    }
    
    // 创建有时间间隔显示的控件
    private func viewForMessage(title:String?,message:String?,image:UIImage?) ->UIView?{
        
        if title == nil && message == nil && image == nil {
            return nil
        }
        
        var titleLabel:UILabel?
        var messageLabel:UILabel?
        var imageView:UIImageView?
        let showView = UIView()
        showView.autoresizingMask = [UIViewAutoresizing.FlexibleLeftMargin,
                                     UIViewAutoresizing.FlexibleRightMargin,
                                     UIViewAutoresizing.FlexibleTopMargin,
                                     UIViewAutoresizing.FlexibleBottomMargin]
        showView.layer.cornerRadius = cornerRadius
        
        // 阴影设置
        if displayShadow {
            showView.layer.shadowColor = UIColor.blackColor().CGColor
            showView.layer.shadowOpacity = shadowOpacity
            showView.layer.shadowRadius = shadowRadius
            showView.layer.shadowOffset = shadowOffset
            
        }
        showView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(opacity)
        
        var imageWidth:CGFloat = 0.0, imageHeight:CGFloat = 0.0, imageTop:CGFloat = 0.0
        
        // imageView的创建与 size设置
        if image != nil {
            imageView = UIImageView()
            imageView?.image = image
            imageView?.contentMode = UIViewContentMode.ScaleAspectFit
            imageView?.frame = CGRect(x: horizontalPadding, y: verticalPadding, width: imageViewWidth, height: imageViewHeight)
            imageWidth = CGRectGetWidth((imageView?.bounds)!)
            imageHeight = CGRectGetHeight((imageView?.bounds)!)
            imageTop = verticalPadding
        }
        
        var titleWidth:CGFloat = 0.0, titleHeight:CGFloat = 0.0, titleTop:CGFloat = 0.0
        
        // titleLabel的创建与 size设置
        if title != nil {
            
            titleLabel = UILabel()
            titleLabel?.numberOfLines = titleLines
            titleLabel?.font = UIFont.boldSystemFontOfSize(titleFontSize)
            titleLabel?.textAlignment = NSTextAlignment.Left
            titleLabel?.textColor = UIColor.whiteColor()
            titleLabel?.backgroundColor = UIColor.clearColor()
            titleLabel?.alpha = 1.0
            titleLabel?.text = title
            
            let maxTitleSize = CGSize(width: bounds.width * proportionWidth - imageWidth, height: bounds.height * proportionHeight)
            let titleStr = title! as NSString
            
            let expextesTitleSize = titleStr.boundingRectWithSize(maxTitleSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: (titleLabel?.font)!], context: nil)
            titleLabel?.frame = CGRect(x: 0.0, y: 0.0, width: expextesTitleSize.width, height: expextesTitleSize.height)
            titleWidth = CGRectGetWidth((titleLabel?.bounds)!)
            titleHeight = CGRectGetHeight((titleLabel?.bounds)!)
            titleTop = verticalPadding
            
        }
        
        // messsageLabel的创建与 size设置
        if message != nil {
            
            messageLabel = UILabel()
            messageLabel?.numberOfLines = messageLines
            messageLabel?.font = UIFont.systemFontOfSize(messageFontSize)
            messageLabel?.textAlignment = NSTextAlignment.Center
            messageLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            messageLabel?.textColor = UIColor.whiteColor()
            messageLabel?.backgroundColor = UIColor.clearColor()
            messageLabel?.alpha = 1.0
            messageLabel?.text = message
            
            let maxMessageSize = CGSize(width: bounds.width * proportionWidth - imageWidth, height: bounds.height * proportionHeight)
            let messageStr = message! as NSString
            
            let expextesMessageSize = messageStr.boundingRectWithSize(maxMessageSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: (messageLabel?.font)!], context: nil)
            messageLabel?.frame = CGRect(x: 0.0, y: 0.0, width: expextesMessageSize.width, height: expextesMessageSize.height)
            
        }
        
        var messageWidth:CGFloat = 0.0, messageHeight:CGFloat = 0.0, messageLeft:CGFloat = 0.0, messageTop:CGFloat = 0.0,messageX:CGFloat = 0.0,messageY:CGFloat = 0.0
        
        if title == nil && image != nil{
            imageWidth = bigImageViewWidth
            imageHeight = bigImageViewHeight
        }
        
        if messageLabel != nil {
            
            messageWidth = CGRectGetWidth((messageLabel?.bounds)!)
            messageHeight = CGRectGetHeight((messageLabel?.bounds)!)
            messageX = horizontalPadding
            messageY = imageTop + imageHeight + verticalPadding
            messageTop = messageY
            messageLeft = messageLeft + horizontalPadding
            
        }
        
        let showWidth = max(imageWidth + titleWidth + horizontalPadding + 2 * horizontalPadding, messageWidth + 2 * horizontalPadding)
        let showHeight = messageTop + messageHeight + verticalPadding
        showView.frame = CGRect(x: 0.0, y: 0.0, width: showWidth, height: showHeight)
        
        var imageViewX:CGFloat = 0.0
        
        if title == nil && image != nil{
            imageViewX = (showWidth - imageWidth) * 0.5
            
        }else if image != nil{
            imageViewX = (showWidth - imageWidth - titleWidth - horizontalPadding) * 0.5
        }
        
        // 重新设置相应控件的frame
        if imageView != nil {
            imageView?.frame = CGRect(x: imageViewX, y: verticalPadding, width: imageWidth, height: imageHeight)
            showView.addSubview(imageView!)
            
        }
        
        if titleLabel != nil {
            let titleLabelX = imageViewX + imageWidth + horizontalPadding
            titleLabel?.frame = CGRect(x: titleLabelX, y: titleTop, width: titleWidth, height: titleHeight)
            showView.addSubview(titleLabel!)
            
        }
        
        if messageLabel != nil {
            
            messageLabel?.frame = CGRect(x: messageX, y: messageY, width: messageWidth, height: messageHeight)
            showView.addSubview(messageLabel!)
            
        }
        
        return showView
    }
    
    // 创建一直显示的View
    private func activityView(text:String?,position:AnyObject?){
        
        let existingActivityView = objc_getAssociatedObject(self, &activityViewKey)
        if existingActivityView != nil {
            return
        }
        
        userInteractionEnabled = false
        
        let activityView = UIView()
        activityView.frame = CGRect(x: 0.0, y: 0.0, width: activityViewWidth, height: activityViewHeight)
        activityView.center = centerPointForPositon(activityView, point: position)
        activityView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(activityOpactity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = [UIViewAutoresizing.FlexibleLeftMargin,
                                         UIViewAutoresizing.FlexibleRightMargin,
                                         UIViewAutoresizing.FlexibleTopMargin,
                                         UIViewAutoresizing.FlexibleBottomMargin]
        activityView.layer.cornerRadius = cornerRadius
        
        if displayShadow {
            activityView.layer.shadowColor = UIColor.blackColor().CGColor
            activityView.layer.shadowOpacity = shadowOpacity
            activityView.layer.shadowRadius = shadowRadius
            activityView.layer.shadowOffset = shadowOffset
            
        }
        
        var indicViewCenterY = CGRectGetHeight(activityView.bounds) * 0.5
        
        if text != nil {
            
            indicViewCenterY = CGRectGetHeight(activityView.bounds) * 0.5 - 10
            let label = UILabel()
            label.frame = CGRect(x: 0.0, y: CGRectGetHeight(activityView.bounds) - 30, width: CGRectGetWidth(activityView.bounds), height: 20)
            label.text = text
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(activityFontSize)
            activityView.addSubview(label)
        }
        
        let indicView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicView.center = CGPoint(x: activityView.bounds.size.width * 0.5, y: indicViewCenterY)
        activityView.addSubview(indicView)
        indicView.startAnimating()
        
        objc_setAssociatedObject(self, &activityViewKey, activityView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        addSubview(activityView)
        
        UIView.animateWithDuration(fadeDuration, delay: 0.0,
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations: { 
                                    activityView.alpha = 1.0
            },
                                   completion: nil)
        
    }
    
    // 移除一直显示的View
    private func hideActivityView(){
        
        let existingActivityView = objc_getAssociatedObject(self, &activityViewKey)
        if existingActivityView != nil {
            
            UIView.animateWithDuration(fadeDuration,
                                       delay: 0.0,
                                       options: [UIViewAnimationOptions.CurveEaseIn,UIViewAnimationOptions.BeginFromCurrentState],
                                       animations: { 
                                        (existingActivityView as! UIView).alpha = 0.0
                                        
                }, completion: { (finished) in
                    
                    existingActivityView.removeFromSuperview()
                    objc_setAssociatedObject(self, &activityViewKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    self.userInteractionEnabled = true
            })
            
        }
        
        
    }
    
    
}
