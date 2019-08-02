//
//  HPCustomAlertController.swift
//  quanquan
//
//  Created by hp on 2019/3/25.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import SnapkitArrayExtention

@objc public enum HPCustomAlertButtonStyle : Int {
    case rectangleFill,roundConnerFill,roundConnerGhost,archGhost,archFill,noneBackground
}
@objc public enum HPCustomAlertControllerStyle : Int {
    case alert,actionSheet
}

@objc open class HPCustomAlertController: UIViewController {
    
    private var bgView:UIView!
    private var contentView:UIView!
    private var iconImageView:UIImageView?
    private var titleLabel: UILabel?
    private var messageLabel: UILabel?
    private var separatorLine:UIView?
    private var separatorColLine: UIView?
    private var actions = Array<HPCustomAlertAction>()
    private var customView:UIView?
    private var buttonEdgeinsets:UIEdgeInsets = UIEdgeInsets(top: 15, left: 29, bottom: 15, right: 29)
    private var alertControllerStyle = HPCustomAlertControllerStyle.alert
    private var cancelButton:UIButton?
    private var cancelAction:(()->Void)?
    @objc public var dimBackground: Bool=true {
        didSet {
            if dimBackground {
                
                bgView.backgroundColor = UIColor.black
                bgView.alpha = 0.5
            } else {
                bgView.backgroundColor = UIColor.clear
            }
        }
    }
    
    @objc public convenience init (custom:UIView,buttonEdgeInsets:UIEdgeInsets,alertStyle:HPCustomAlertControllerStyle = .alert) {
        self.init()
        self.customView = custom
        self.alertControllerStyle = alertStyle
        self.buttonEdgeinsets = buttonEdgeInsets
        buildUI()
    }
    
    public convenience init (title:String?,message:String,iconName:String?=nil) {
        self.init(title: title,
                  titleColor: nil,
                  message: message,
                  iconName: iconName,
                  buttonEdgeInsets: nil,
                  alertStyle: .alert)
    }
    
    public convenience init(title:String?,
                            titleColor:UIColor?,
                            message:String,
                            iconName:String?=nil,
                            buttonEdgeInsets:UIEdgeInsets?,
                            alertStyle:HPCustomAlertControllerStyle = .alert) {
        
        self.init()
        self.alertControllerStyle = alertStyle
        if buttonEdgeInsets != nil {
            self.buttonEdgeinsets = buttonEdgeInsets!
        }
        buildUI()
        if let title = title {
            if #available(iOS 8.2, *) {
                titleLabel = createLabel(color: (titleColor ?? RGB51), alignment: .center, font: UIFont.systemFont(ofSize: 16, weight: .semibold))
            } else {
                titleLabel = createLabel(color: (titleColor ?? RGB51), alignment: .center, font: UIFont.systemFont(ofSize: 16))
            }
            titleLabel?.text = title
            contentView.addSubview(titleLabel!)
        }
        messageLabel?.text = message
        if let iconName = iconName {
            iconImageView = UIImageView()
            iconImageView?.layer.cornerRadius = 40
            iconImageView?.layer.masksToBounds = true
            iconImageView?.contentMode = .scaleAspectFill
            iconImageView?.image = UIImage(named: iconName)
            contentView.addSubview(iconImageView!)
        }
    }
    
    /// 生成弹窗对象
    ///
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 描述信息
    ///   - iconName: 图标
    /// - Returns: 返回弹窗对象
    @objc public class func alert(title:String?,message:String,iconName:String?=nil)->HPCustomAlertController {
        return HPCustomAlertController(title: title,
                                       titleColor: nil,
                                       message: message,
                                       iconName: iconName,
                                       buttonEdgeInsets: nil,
                                       alertStyle: .alert)
    }
    
    /// 生成弹窗对象
    ///
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - titleColor: 标题颜色
    ///   - message: 详细信息
    ///   - iconName: 图标
    ///   - buttonStyle: 按钮的样式
    /// - Returns: 弹窗t对象
    @objc public class func alert(title:String?,
                                  titleColor:UIColor?,
                                  message:String,
                                  iconName:String?=nil,
                                  buttonEdgeInsets:UIEdgeInsets,
                                  alertStyle:HPCustomAlertControllerStyle = .alert)->HPCustomAlertController {
        
        return HPCustomAlertController(title: title,
                                       titleColor: titleColor,
                                       message: message,
                                       iconName: iconName,
                                       buttonEdgeInsets: buttonEdgeInsets,
                                       alertStyle: alertStyle)
    }
    
    @objc public class func alert(custom:UIView,buttonEdgeInsets:UIEdgeInsets,alertStyle:HPCustomAlertControllerStyle = .alert)->HPCustomAlertController {
        return HPCustomAlertController(custom: custom, buttonEdgeInsets: buttonEdgeInsets, alertStyle: alertStyle)
    }
    
    /// 添加按钮
    ///
    /// - Parameter action: 按钮对象
    @objc public func add(action:HPCustomAlertAction) {
        action.alertController = self
        actions.append(action)
        contentView.addSubview(action.button!)
    }
    
    /// 添加自定义视图
    ///
    /// - Parameter custom: 自定义的视图，默认约束：有按钮是(0,0,0,10)，无按钮(0,0,0,0)
    @objc public func add(custom:UIView?) {
        customView = custom
        if let customView = custom {
            contentView.addSubview(customView)
        }
    }
    
    /// 弹出弹窗
    ///
    /// - Parameter aViewController: 当前弹窗所在的控制器
    @objc public func show(aViewController:UIViewController) {
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        aViewController.present(self, animated: true)
    }
    
    func buildUI() {
        bgView = UIView()
        if dimBackground {
            bgView.backgroundColor = UIColor.black
            bgView.alpha = 0.5
        }
        contentView = UIView()
        contentView.backgroundColor = RGB(r: 255, g: 255, b: 255)
        contentView.layer.cornerRadius = 10.0;
        contentView.layer.masksToBounds = true
        view.addSubview(bgView)
        view.addSubview(contentView)
        
        //        let effect = UIBlurEffect(style: .light)
        //        let blurView = UIVisualEffectView(effect: effect)
        //        contentView.addSubview(blurView)
        if let custom = self.customView {
            contentView.addSubview(custom)
        } else {
            
            messageLabel = createLabel(color: RGB(r: 102, g: 102, b: 102), alignment: .center, font: UIFont.systemFont(ofSize: 14))
            contentView.addSubview(messageLabel!)
        }
        separatorLine = UIView()
        separatorLine?.backgroundColor = RGB(r: 238, g: 238, b: 238)
        separatorColLine = UIView()
        separatorColLine?.backgroundColor = RGB(r: 238, g: 238, b: 238)
        contentView.addSubview(separatorLine!)
        contentView.addSubview(separatorColLine!)
        
        bgView.snp.updateConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.zero)
        }
        contentView.snp.updateConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(40)
            maker.right.equalTo(-40)
        }
        //        blurView.snp.makeConstraints { (maker) in
        //            maker.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        //        }
    }
    override open func updateViewConstraints() {
        if let customView = customView {
            contentView.addSubview(customView)
            customView.snp.makeConstraints { (maker) in
                maker.left.right.top.equalToSuperview()
                if actions.count==0 {
                    maker.bottom.equalTo(0)
                }
            }
        } else {
            
            if titleLabel?.superview != nil {
                titleLabel?.snp.updateConstraints({ (maker) in
                    if iconImageView?.superview != nil {
                        maker.top.equalTo(self.iconImageView!.snp.bottom).offset(20)
                    } else {
                        maker.top.equalTo(20)
                    }
                    maker.left.equalTo(26)
                    maker.right.equalTo(-26)
                    maker.height.lessThanOrEqualTo(36)
                })
            }
            if iconImageView?.superview != nil {
                iconImageView?.snp.updateConstraints { (maker) in
                    maker.centerX.equalToSuperview()
                    maker.top.equalTo(32)
                    maker.width.height.equalTo(80)
                }
            }
            messageLabel?.snp.updateConstraints({ (maker) in
                if titleLabel?.superview != nil {
                    maker.top.equalTo(self.titleLabel!.snp.bottom).offset(20)
                } else {
                    maker.top.equalTo(20)
                }
                maker.left.equalTo(26)
                maker.right.equalTo(-26)
                if actions.count==0 {
                    maker.bottom.equalTo(-20)
                }
            })
        }
        
        if actions.count>0 {
            var axis = NSLayoutConstraint.Axis.horizontal
            if alertControllerStyle == .actionSheet {
                axis = .vertical
            }
            var buttons = Array<UIButton>()
            for item in contentView.subviews {
                if item is UIButton {
                    buttons.append(item as! UIButton)
                }
            }
            let buttonHeight = 50-(self.buttonEdgeinsets.top+self.buttonEdgeinsets.bottom)
            
            if buttons.count==1 {
                buttons.snp.makeConstraints { (maker) in
                    maker.top.equalTo(messageLabel!.snp.bottom).offset(buttonEdgeinsets.top)
                    maker.left.equalTo(buttonEdgeinsets.left)
                    maker.right.equalTo(-buttonEdgeinsets.right)
                    maker.bottom.equalTo((-buttonEdgeinsets.bottom))
                    maker.height.equalTo(buttonHeight)
                }
            } else if buttons.count==2 {
                if axis == .horizontal {
                    
                    separatorLine?.snp.makeConstraints({ (maker) in
                        maker.left.right.equalToSuperview()
                        if let custom = customView {
                            maker.top.equalTo(custom.snp.bottom).offset(15)
                        } else {
                            maker.top.equalTo(messageLabel!.snp.bottom).offset(20)
                        }
                        maker.height.equalTo(0.5)
                    })
                    separatorColLine?.snp.makeConstraints({ (maker) in
                        maker.centerX.equalToSuperview()
                        maker.top.equalTo(separatorLine!.snp.bottom)
                        maker.width.equalTo(0.5)
                        maker.bottom.equalToSuperview()
                    })
                    buttons.snp.distributeViewsAlong(axisType: axis, fixedSpacing: buttonEdgeinsets.left+buttonEdgeinsets.right, leadSpacing: buttonEdgeinsets.left, tailSpacing: buttonEdgeinsets.right)
                    buttons.snp.makeConstraints { (maker) in
                        maker.top.equalTo(self.separatorLine!.snp.bottom).offset(buttonEdgeinsets.top)
                        maker.bottom.equalTo((-buttonEdgeinsets.bottom))
                        maker.height.equalTo(buttonHeight)
                    }
                } else {
                    separatorLine?.isHidden = true
                    separatorColLine?.isHidden = true
                    let tmp = contentView.viewWithTag(111111) ?? UIView(frame: .zero)
                    tmp.tag = 111111
                    contentView.addSubview(tmp)
                    for item in buttons.enumerated() {
                        tmp.addSubview(item.element)
                    }
                    tmp.snp.makeConstraints { (maker) in
                        maker.left.right.equalToSuperview()
                        maker.bottom.equalTo(-6)
                        if let custom = customView {
                            maker.top.equalTo(custom.snp.bottom).offset(15)
                        } else {
                            maker.top.equalTo(messageLabel!.snp.bottom).offset(15)
                        }
                    }
                    buttons.snp.distributeViewsAlong(axisType: axis, fixedSpacing: 8, leadSpacing: buttonEdgeinsets.top, tailSpacing: buttonEdgeinsets.bottom)
                    buttons.snp.makeConstraints { (maker) in
                        maker.left.equalTo(buttonEdgeinsets.left)
                        maker.right.equalTo((-buttonEdgeinsets.right))
                        maker.height.equalTo(buttonHeight)
                    }
                }
            } else {
                separatorLine?.isHidden = true
                separatorColLine?.isHidden = true
                let tmp = contentView.viewWithTag(111111) ?? UIView(frame: .zero)
                tmp.tag = 111111
                for item in buttons.enumerated() {
                    tmp.addSubview(item.element)
                }
                tmp.snp.makeConstraints { (maker) in
                    maker.left.right.equalToSuperview()
                    maker.bottom.equalTo(-6)
                    if let custom = customView {
                        maker.top.equalTo(custom.snp.bottom).offset(15)
                    } else {
                        maker.top.equalTo(messageLabel!.snp.bottom).offset(15)
                    }
                }
                buttons.snp.distributeViewsAlong(axisType: axis, fixedSpacing: 8, leadSpacing: buttonEdgeinsets.top, tailSpacing: buttonEdgeinsets.bottom)
                buttons.snp.makeConstraints { (maker) in
                    maker.left.equalTo(buttonEdgeinsets.left)
                    maker.right.equalTo((-buttonEdgeinsets.right))
                    maker.height.equalTo(buttonHeight)
                }
            }
        } else {
            separatorLine?.isHidden = true
            separatorColLine?.isHidden = true
        }
        
        cancelButton?.snp.makeConstraints({ (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(self.contentView.snp.bottom).offset(42)
            maker.width.height.equalTo(36)
        })
        super.updateViewConstraints()
    }
    
    @objc public func showCancel(_ imageName:String?,action:(()->Void)?) {
        let tmp = UIButton(type: .custom)
        if let imageName = imageName {
            tmp.setImage(UIImage(named: imageName), for: .normal)
        }
        tmp.addTarget(self, action: #selector(doCancelAction), for: .touchUpInside)
        cancelAction = action
        cancelButton = tmp
        view.addSubview(tmp)
        //        view.bringSubview(toFront: tmp)
        //        view.updateConstraintsIfNeeded()
    }
    
    @objc private func doCancelAction() {
        cancelAction?()
        dismiss(animated: true, completion: nil)
    }
    
    func createLabel(color:UIColor?,alignment:NSTextAlignment?,font:UIFont?) -> UILabel {
        let tmp = UILabel()
        tmp.textColor = color
        if let aligment = alignment {
            tmp.textAlignment = aligment
        }
        tmp.numberOfLines = 0
        tmp.font = font;
        return tmp
    }
}

@objc public class HPCustomAlertAction: NSObject {
    fileprivate var clickAction:(()->Void)?
    fileprivate var button:UIButton?
    fileprivate weak var alertController:UIViewController?
    private var autoDismiss:Bool = true
    public convenience init(title:String,bgImageName:String?,titleColor:UIColor?,action:(() -> Void)? = nil) {
        self.init(title: title,
                  backgroundColor:nil,
                  bgImageName: bgImageName,
                  titleColor: titleColor,
                  buttonStyle: .rectangleFill,
                  action: action)
    }
    public convenience init(title:String,
                            _ attributeString:NSAttributedString? = nil,
                            backgroundColor:UIColor?,
                            bgImageName:String?,
                            titleColor:UIColor?,
                            buttonStyle:HPCustomAlertButtonStyle,
                            autoDismiss:Bool = true,
                            action:(() -> Void)? = nil) {
        self.init()
        self.autoDismiss = autoDismiss
        button = createButton(textColor: titleColor,
                              backgroundColor: backgroundColor,
                              bgImageName: bgImageName,
                              title: title,
                              attributeString,
                              buttonStyle: buttonStyle,
                              autoDismiss:autoDismiss,
                              action: action)
    }
    /// 添加按钮事件
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - bgImageName: 按钮背景图片
    ///   - titleColor: 按钮颜色
    ///   - action: 按钮事件
    /// - Returns: 按钮
    @objc public class func action(title:String,
                                   bgImageName:String?,
                                   titleColor:UIColor?=RGB(r: 30, g: 144, b: 255),
                                   action:(() -> Void)? = nil) -> HPCustomAlertAction{
        
        return HPCustomAlertAction(title: title,
                                   backgroundColor:nil,
                                   bgImageName: bgImageName,
                                   titleColor: titleColor,
                                   buttonStyle: .rectangleFill,
                                   action: action)
    }
    
    @objc public class func action(title:String,
                                   _ attributeString:NSAttributedString? = nil,
                                   backgroundColor:UIColor?,
                                   bgImageName:String?,
                                   titleColor:UIColor?=RGB(r: 30, g: 144, b: 255),
                                   buttonStyle:HPCustomAlertButtonStyle,
                                   autoDismiss:Bool = true,
                                   action:(() -> Void)? = nil) -> HPCustomAlertAction{
        
        var textColor = titleColor
        if textColor==nil {
            textColor = RGB(r: 30, g: 144, b: 255)
        }
        return HPCustomAlertAction(title: title,
                                   attributeString,
                                   backgroundColor:backgroundColor,
                                   bgImageName: bgImageName,
                                   titleColor: textColor,
                                   buttonStyle: buttonStyle,
                                   autoDismiss:autoDismiss,
                                   action: action)
    }
    
    fileprivate func createButton(textColor:UIColor?,
                                  backgroundColor:UIColor?,
                                  bgImageName:String?,
                                  title:String,
                                  _ attributeString:NSAttributedString? = nil,
                                  buttonStyle:HPCustomAlertButtonStyle,
                                  autoDismiss:Bool,
                                  action:(() -> Void)? = nil) -> UIButton {
        
        let tmp = UIButton(type: .custom)
        tmp.setTitleColor((textColor ?? RGB51), for: .normal)
        tmp.backgroundColor = backgroundColor
        tmp.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        tmp.setTitle(title, for: .normal)
        tmp.setAttributedTitle(attributeString, for: .normal)
        if let bgImageName = bgImageName {
            tmp.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        } else {
            if (buttonStyle == .rectangleFill) {
                
            } else if (buttonStyle == .archGhost) {
                tmp.layer.borderColor = RGB153.cgColor
                tmp.layer.borderWidth = 1
                tmp.layer.cornerRadius = 18
            } else if (buttonStyle == .roundConnerGhost) {
                tmp.layer.cornerRadius = 5
                tmp.layer.borderColor = RGB153.cgColor
                tmp.layer.borderWidth = 1
            } else if (buttonStyle == .archFill) {
                
                tmp.layer.cornerRadius = 18
                tmp.layer.masksToBounds = true
            } else if (buttonStyle == .roundConnerFill) {
                tmp.layer.cornerRadius = 5
                tmp.layer.masksToBounds = true
            } else if (buttonStyle == .noneBackground) {
                
            }
        }
        clickAction = action
        tmp .addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        return tmp
    }
    
    @objc fileprivate func buttonClick(sender:UIButton) {
        if autoDismiss {
            alertController?.dismiss(animated: true, completion: nil)
        }
        clickAction?()
    }
}
