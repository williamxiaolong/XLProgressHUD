//
//  XLProgressHUD.swift
//  XLProgressHUD
//
//  Created by yuanxiaolong on 16/6/1.
//  Copyright © 2016年 yuanxiaolong. All rights reserved.
//
import UIKit
import Foundation

fileprivate let SCREEN = UIScreen.main.bounds.size
fileprivate let SCREEN_W = SCREEN.width
fileprivate let SCREEN_H = SCREEN.height
fileprivate func iPhoneX() -> Bool {
    return (SCREEN_W == 375.0 && SCREEN_H == 812.0)
}
/// 44/20
fileprivate func StatusBarHeight() -> CGFloat {
    return iPhoneX() ? 44.0 : 20.0
}
/// 34 / 0
fileprivate func TabbarSafeBottomMargin() -> CGFloat {
    return iPhoneX() ? 34.0 : 0.0
}

public enum XLHUDConfigType: Int {
    case center
    case top
    case bottom
}

class XLHUDConfig {
    // 总体
    var proportionWidth: CGFloat     = 0.8     //80%的占比宽度
    var proportionHeight: CGFloat    = 0.8     //80%的占比高度
    var horizontalPadding: CGFloat   = 10.0
    var verticalPadding: CGFloat     = 10.0
    var topMargin: CGFloat           = StatusBarHeight()
    var bottomMargin: CGFloat        = TabbarSafeBottomMargin()
    var cornerRadius: CGFloat        = 10.0
    var opacity: CGFloat             = 0.7
    var titleFontSize: CGFloat       = 16.0
    var messageFontSize: CGFloat     = 16.0
    var titleLines                   = 0
    var messageLines                 = 0
    let fadeDuration: Double         = 0.2

    var defaultType: XLHUDConfigType = .center

    // 阴影
    var shadowOpacity: Float         = 0.8
    var shadowRadius: CGFloat        = 5.0
    var shadowOffset                 = CGSize(width: 2, height: 2)
    var displayShadow                = true

    // 图片
    var imageViewWidth: CGFloat      = 20.0
    var imageViewHeight: CGFloat     = 20.0
    var bigImageViewWidth: CGFloat   = 30.0
    var bigImageViewHeight: CGFloat  = 30.0

    // 一直显示的View
    var activityViewWidth: CGFloat   = 120
    var activityViewHeight: CGFloat  = 100
    var activityOpactity: CGFloat    = 0.7
    var activityFontSize: CGFloat    = 14.0
}

fileprivate let activityViewTag     = 1214

extension UIView{
    //MARK:- Public
    // 只含有提示信息的提示
    public func showMessage(_ message: String?, interval: CGFloat = 1.68, position: XLHUDConfigType = .center){
        if let view = viewForMessage(title: nil, message: message, image: nil) {
            showView(view: view, interval: interval, point: position as AnyObject)
        }
    }
    public func showMessage(_ message: String?, interval: CGFloat, position: CGPoint){
        if let view = viewForMessage(title: nil, message: message, image: nil) {
            showView(view: view, interval: interval, point: position as AnyObject)
        }
    }
    
    // 含有提示信息和图片的提示
    public func showMessageAndImage(_ message: String?, image: UIImage?, interval: CGFloat = 1.68, position: XLHUDConfigType = .center ){
        if let view = viewForMessage(title: nil, message: message, image: image) {
            showView(view: view, interval: interval, point: position as AnyObject)
        }
    }
    public func showMessageAndImage(_ message: String?, image: UIImage?, interval: CGFloat, position: CGPoint ){
        if let view = viewForMessage(title: nil, message: message, image: image) {
            showView(view: view, interval: interval, point: position as AnyObject)
        }
    }
    
    // 含有标题、信息和图片的提示
    public func showTitleMessageAndImage(_ title: String?, message: String?, image: UIImage?, interval: CGFloat = 1.68,position: XLHUDConfigType = .center) {
        if let view = viewForMessage(title: title, message: message, image: image) {
            showView(view: view, interval: interval, point: position as AnyObject)
        }
    }
    
    public func showTitleMessageAndImage(_ title: String?, message: String?, image: UIImage?, interval: CGFloat, position: CGPoint) {
        if let view = viewForMessage(title: title, message: message, image: image) {
            showView(view: view, interval: interval, point: position as AnyObject)
        }
        
    }
    
    // 含有提示信息的加载提示
    public func showLoadingTilteActivity(_ message: String, position: XLHUDConfigType = .center){
        activityView(text: message, position: position as AnyObject)
    }
    public func showLoadingTilteActivity(_ message: String, position: CGPoint){
        activityView(text: message, position: position as AnyObject)
    }
    
    // 没有提示信息的加载提示
    public func showLoadingActivity(_ position: XLHUDConfigType = .center){
        activityView(text: nil, position: position as AnyObject)
    }
    public func showLoadingActivity(_ position: CGPoint){
        activityView(text: nil, position: position as AnyObject)
    }
    
    // 隐藏提示
    public func hideActivity(_ interval: Double = 0.2){
        hideActivityView(interval)
    }
    
    //MARK:- Private
    private func showView(view:UIView,interval:CGFloat,point:AnyObject) {
        showView(view: view, interval: interval, point: point, config: nil)
    }
    
    // 控件显示（控件显示停留时间与动画）
    private func showView(view:UIView,interval:CGFloat,point:AnyObject, config: XLHUDConfig?){
        var m = config
        if m == nil {
           m = XLHUDConfig()
        }
        view.center = centerPointForPositon(view: view, point: point)
        view.alpha = 0.0
        addSubview(view)
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: m!.fadeDuration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        view.alpha = 1.0
        }) { (finished) in
            
            UIView.animate(withDuration: m!.fadeDuration,
                                  delay: Double(interval),
                                options: .curveEaseIn,
                             animations: {
                view.alpha = 0.0
            }, completion: { (finished) in
                view.removeFromSuperview()
                self.isUserInteractionEnabled = true
            })
            
        }
        
    }
    
    private func centerPointForPositon(view:UIView,point:AnyObject?) -> CGPoint{
        return centerPointForPositon(view: view, point: point, config: nil)
    }
    
    // 设置控件位置
    private func centerPointForPositon(view:UIView,point:AnyObject?, config: XLHUDConfig?) -> CGPoint{
        var m = config
        if m == nil {
            m = XLHUDConfig()
        }
        
        if point is XLHUDConfigType {
            
            let pointType = point as! XLHUDConfigType
            if pointType == .top {
                
                return CGPoint(x: bounds.size.width * 0.5, y: m!.topMargin + view.bounds.size.height * 0.5)
            } else if pointType == .bottom {
                return CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height - view.bounds.size.height * 0.5 - m!.bottomMargin - 20)
            } else {
                return CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
            }
            
        } else if point is CGPoint{
            return point as! CGPoint
        } else {
            return centerPointForPositon(view: view, point: m!.defaultType as AnyObject)
        }
        
    }
    
    private func viewForMessage(title:String?,message:String?,image:UIImage?) ->UIView?{
        return viewForMessage(title: title, message: message, image: image, config: nil)
    }
    
    // 创建有时间间隔显示的控件
    private func viewForMessage(title:String?,message:String?,image:UIImage?, config: XLHUDConfig?) ->UIView?{
        var m = config
        if m == nil {
            m = XLHUDConfig()
        }
        
        if title == nil && message == nil && image == nil {
            return nil
        }
        
        var titleLabel:UILabel?
        var messageLabel:UILabel?
        var imageView:UIImageView?
        let showView = UIView()
        showView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin,
                                     UIViewAutoresizing.flexibleRightMargin,
                                     UIViewAutoresizing.flexibleTopMargin,
                                     UIViewAutoresizing.flexibleBottomMargin]
        showView.layer.cornerRadius = m!.cornerRadius
        
        // 阴影设置
        if m!.displayShadow {
            showView.layer.shadowColor = UIColor.black.cgColor
            showView.layer.shadowOpacity = m!.shadowOpacity
            showView.layer.shadowRadius = m!.shadowRadius
            showView.layer.shadowOffset = m!.shadowOffset
            
        }
        showView.backgroundColor = UIColor.black.withAlphaComponent(m!.opacity)
        
        var imageWidth:CGFloat = 0.0, imageHeight:CGFloat = 0.0, imageTop:CGFloat = 0.0
        
        // imageView的创建与 size设置
        if image != nil {
            imageView = UIImageView()
            imageView?.image = image
            imageView?.contentMode = .scaleAspectFit
            imageView?.frame = CGRect(x: m!.horizontalPadding, y: m!.verticalPadding, width: m!.imageViewWidth, height: m!.imageViewHeight)
            imageWidth = imageView!.bounds.width
            imageHeight = imageView!.bounds.height
            imageTop = m!.verticalPadding
        }
        
        var titleWidth:CGFloat = 0.0, titleHeight:CGFloat = 0.0, titleTop:CGFloat = 0.0
        
        // titleLabel的创建与 size设置
        if title != nil {
            
            titleLabel = UILabel()
            titleLabel?.numberOfLines = m!.titleLines
            titleLabel?.font = UIFont.boldSystemFont(ofSize: m!.titleFontSize)
            titleLabel?.textAlignment = .left
            titleLabel?.textColor = .white
            titleLabel?.backgroundColor = .clear
            titleLabel?.alpha = 1.0
            titleLabel?.text = title
            
            let maxTitleSize = CGSize(width: bounds.width * m!.proportionWidth - imageWidth, height: bounds.height * m!.proportionHeight)
            let titleStr = title! as NSString
            
            let expextesTitleSize = titleStr.boundingRect(with: maxTitleSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: (titleLabel?.font)!], context: nil)
            titleLabel?.frame = CGRect(x: 0.0, y: 0.0, width: expextesTitleSize.width, height: expextesTitleSize.height)
            titleWidth = titleLabel!.bounds.width
            titleHeight = titleLabel!.bounds.height
            titleTop = m!.verticalPadding
            
        }
        
        // messsageLabel的创建与 size设置
        if message != nil {
            
            messageLabel = UILabel()
            messageLabel?.numberOfLines = m!.messageLines
            messageLabel?.font = UIFont.systemFont(ofSize: m!.messageFontSize)
            messageLabel?.textAlignment = .center
            messageLabel?.lineBreakMode = .byWordWrapping
            messageLabel?.textColor = .white
            messageLabel?.backgroundColor = .clear
            messageLabel?.alpha = 1.0
            messageLabel?.text = message
            
            let maxMessageSize = CGSize(width: bounds.width * m!.proportionWidth - imageWidth, height: bounds.height * m!.proportionHeight)
            let messageStr = message! as NSString
            
            let expextesMessageSize = messageStr.boundingRect(with: maxMessageSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: (messageLabel?.font)!], context: nil)
            messageLabel?.frame = CGRect(x: 0.0, y: 0.0, width: expextesMessageSize.width, height: expextesMessageSize.height)
            
        }
        
        var messageWidth:CGFloat = 0.0, messageHeight:CGFloat = 0.0, messageLeft:CGFloat = 0.0, messageTop:CGFloat = 0.0,messageX:CGFloat = 0.0,messageY:CGFloat = 0.0
        
        if title == nil && image != nil{
            imageWidth = m!.bigImageViewWidth
            imageHeight = m!.bigImageViewHeight
        }
        
        if messageLabel != nil {
            
            messageWidth = messageLabel!.bounds.width
            messageHeight = messageLabel!.bounds.height
            messageX = m!.horizontalPadding
            messageY = imageTop + imageHeight + m!.verticalPadding
            messageTop = messageY
            messageLeft = messageLeft + m!.horizontalPadding
            
        }
        
        let showWidth = max(imageWidth + titleWidth + m!.horizontalPadding + 2 * m!.horizontalPadding, messageWidth + 2 * m!.horizontalPadding)
        let showHeight = messageTop + messageHeight + m!.verticalPadding
        showView.frame = CGRect(x: 0.0, y: 0.0, width: showWidth, height: showHeight)
        
        var imageViewX:CGFloat = 0.0
        
        if title == nil && image != nil{
            imageViewX = (showWidth - imageWidth) * 0.5
            
        }else if image != nil{
            imageViewX = (showWidth - imageWidth - titleWidth - m!.horizontalPadding) * 0.5
        }
        
        // 重新设置相应控件的frame
        if imageView != nil {
            imageView?.frame = CGRect(x: imageViewX, y: m!.verticalPadding, width: imageWidth, height: imageHeight)
            showView.addSubview(imageView!)
            
        }
        
        if titleLabel != nil {
            let titleLabelX = imageViewX + imageWidth + m!.horizontalPadding
            titleLabel?.frame = CGRect(x: titleLabelX, y: titleTop, width: titleWidth, height: titleHeight)
            showView.addSubview(titleLabel!)
            
        }
        
        if messageLabel != nil {
            messageLabel?.frame = CGRect(x: messageX, y: messageY, width: messageWidth, height: messageHeight)
            showView.addSubview(messageLabel!)
        }
        print(showView.frame)
        return showView
    }
    
    private func activityView(text:String?,position:AnyObject?){
        activityView(text: text, position: position, config: nil)
    }
    
    // 创建一直显示的View
    private func activityView(text:String?,position:AnyObject?, config: XLHUDConfig?){
        var m = config
        if m == nil {
            m = XLHUDConfig()
        }
        
        let existingActivityView = viewWithTag(activityViewTag)
        if existingActivityView != nil {
            return
        }
        
        isUserInteractionEnabled = false
        
        let activityView = UIView()
        activityView.frame = CGRect(x: 0.0, y: 0.0, width: m!.activityViewWidth, height: m!.activityViewHeight)
        activityView.center = centerPointForPositon(view: activityView, point: position)
        activityView.tag = activityViewTag
        activityView.backgroundColor = UIColor.black.withAlphaComponent(m!.activityOpactity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin,
                                         UIViewAutoresizing.flexibleRightMargin,
                                         UIViewAutoresizing.flexibleTopMargin,
                                         UIViewAutoresizing.flexibleBottomMargin]
        activityView.layer.cornerRadius = m!.cornerRadius
        
        if m!.displayShadow {
            activityView.layer.shadowColor = UIColor.black.cgColor
            activityView.layer.shadowOpacity = m!.shadowOpacity
            activityView.layer.shadowRadius = m!.shadowRadius
            activityView.layer.shadowOffset = m!.shadowOffset
            
        }
        
        var indicViewCenterY = activityView.bounds.height * 0.5
        
        if text != nil {
            
            indicViewCenterY = activityView.bounds.height * 0.5 - 10
            let label = UILabel()
            label.frame = CGRect(x: 0.0, y: activityView.bounds.height - 30, width: activityView.bounds.width, height: 20)
            label.text = text
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: m!.activityFontSize)
            activityView.addSubview(label)
        }
        
        let indicView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicView.center = CGPoint(x: activityView.bounds.size.width * 0.5, y: indicViewCenterY)
        activityView.addSubview(indicView)
        indicView.startAnimating()
        
        addSubview(activityView)
        
        UIView.animate(withDuration: m!.fadeDuration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        activityView.alpha = 1.0 },
                       completion: nil)
        
    }
    
    // 移除一直显示的View
    private func hideActivityView(_ interval: Double){
        
        if let existingActivityView = viewWithTag(activityViewTag) {
            UIView.animate(withDuration: interval,
                           delay: 0.0,
                           options: [.curveEaseIn,.beginFromCurrentState],
                           animations: {
                            existingActivityView.alpha = 0.0
            }, completion: { (finished) in
                existingActivityView.removeFromSuperview()
                self.isUserInteractionEnabled = true
            })
        }
    }
    
    
}

