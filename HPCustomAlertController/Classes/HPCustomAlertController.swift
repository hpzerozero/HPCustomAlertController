//
//  HPCustomAlertController.swift
//  quanquan
//
//  Created by hp on 2019/3/25.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import SnapkitArrayExtention
@objc class HPCustomAlertController: UIViewController {

    private var bgView:UIView!
    private var contentView:UIView!
    private var iconImageView:UIImageView?
    private var titleLabel: UILabel?
    private var messageLabel: UILabel?
    private var separatorLine:UIView?
    private var separatorColLine: UIView?
    private var actions = Array<HPCustomAlertAction>()
    private var customView:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private convenience init (title:String?,message:String,iconName:String?) {
        self.init()
        buildUI()
        if let title = title {
            if #available(iOS 8.2, *) {
                titleLabel = createLabel(color: RGB51, alignment: .center, font: UIFont.systemFont(ofSize: 16, weight: .semibold))
            } else {
                titleLabel = createLabel(color: RGB51, alignment: .center, font: UIFont.systemFont(ofSize: 16))
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
    @objc class func alert(title:String?,message:String,iconName:String?)->HPCustomAlertController {
        return HPCustomAlertController(title: title, message: message, iconName: iconName)
    }
    
    /// 添加按钮
    ///
    /// - Parameter action: 按钮对象
    @objc func add(action:HPCustomAlertAction) {
        action.alertController = self
        actions.append(action)
        contentView.addSubview(action.button!)
    }
    
    /// 添加自定义视图
    ///
    /// - Parameter custom: 自定义的视图，默认约束：有按钮是(0,0,0,10)，无按钮(0,0,0,0)
    @objc func add(custom:UIView?) {
        customView = custom
        if let customView = custom {
            contentView.addSubview(customView)
        }
    }
    
    /// 弹出弹窗
    ///
    /// - Parameter aViewController: 当前弹窗所在的控制器
    @objc func show(aViewController:UIViewController) {
        view.setNeedsUpdateConstraints()
        view.updateConstraintsIfNeeded()
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        aViewController.present(self, animated: true)
    }
    
    func buildUI() {
        bgView = UIView()
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.5
        contentView = UIView()
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.7)
        contentView.layer.cornerRadius = 10.0;
        contentView.layer.masksToBounds = true
        
        let effect = UIBlurEffect(style: .extraLight)
        let blurView = UIVisualEffectView(effect: effect)
        contentView.addSubview(blurView)
        messageLabel = createLabel(color: RGB(r: 102, g: 102, b: 102), alignment: .center, font: UIFont.systemFont(ofSize: 14))
        separatorLine = UIView()
        separatorLine?.backgroundColor = RGB153
        separatorColLine = UIView()
        separatorColLine?.backgroundColor = RGB153
        
        view.addSubview(bgView)
        view.addSubview(contentView)
        contentView.addSubview(messageLabel!)
        contentView.addSubview(separatorLine!)
        contentView.addSubview(separatorColLine!)
        bgView.snp.updateConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets.zero)
        }
        contentView.snp.updateConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.left.equalTo(37)
            maker.right.equalTo(-37)
        }
        blurView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    override func updateViewConstraints() {
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
                        maker.top.equalTo(15)
                    }
                    maker.left.equalTo(15)
                    maker.right.equalTo(-15)
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
                    maker.top.equalTo(self.titleLabel!.snp.bottom).offset(15)
                } else {
                    maker.top.equalTo(15)
                }
                maker.left.equalTo(20)
                maker.right.equalTo(-20)
                if actions.count==0 {
                    maker.bottom.equalTo(-10)
                }
            })
        }
        
        if actions.count>0 {
            var buttons = Array<UIButton>()
            for item in contentView.subviews {
                if item is UIButton {
                    buttons.append(item as! UIButton)
                }
            }
            if buttons.count==1 {
                buttons.snp.makeConstraints { (maker) in
                    maker.top.equalTo(messageLabel!.snp.bottom).offset(10)
                    maker.left.equalTo(29)
                    maker.right.equalTo(-29)
                    maker.bottom.equalTo((-10))
                    maker.height.equalTo(36)
                }
                
            } else if buttons.count==2 {
                separatorLine?.snp.makeConstraints({ (maker) in
                    maker.left.right.equalToSuperview()
                    if let custom = customView {
                        maker.top.equalTo(custom.snp.bottom).offset(10)
                    } else {
                        maker.top.equalTo(messageLabel!.snp.bottom).offset(15)
                    }
                    maker.height.equalTo(0.5)
                })
                separatorColLine?.snp.makeConstraints({ (maker) in
                    maker.centerX.equalToSuperview()
                    maker.top.equalTo(separatorLine!.snp.bottom)
                    maker.width.equalTo(0.5)
                    maker.bottom.equalToSuperview()
                })
                buttons.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 45, leadSpacing: 29, tailSpacing: 29)
                buttons.snp.makeConstraints { (maker) in
                    maker.top.equalTo(self.separatorLine!.snp.bottom).offset(10)
                    maker.bottom.equalTo((-10))
                    maker.height.equalTo(36)
                }
            } else {
                buttons.snp.distributeViewsAlong(axisType: .vertical, fixedSpacing: 10, leadSpacing: 29, tailSpacing: 29)
                buttons.snp.makeConstraints { (maker) in
                    maker.top.equalTo(self.messageLabel!.snp.bottom).offset(10)
                    maker.bottom.equalTo((-10))
                    maker.height.equalTo(36)
                }
            }
        } else {
            separatorLine?.isHidden = true
            separatorColLine?.isHidden = true
        }
        
        
        super.updateViewConstraints()
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

@objc class HPCustomAlertAction: NSObject {
    fileprivate var clickAction:(()->Void)?
    fileprivate var button:UIButton?
    fileprivate weak var alertController:UIViewController?
    private convenience init(title:String,bgImageName:String?,titleColor:UIColor?,action:(() -> Void)? = nil) {
        self.init()
        button = createButton(textColor: titleColor, backgroundColor: nil, bgImageName: bgImageName, title: title, action: action)
    }
    
    /// 添加按钮事件
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - bgImageName: 按钮背景图片
    ///   - titleColor: 按钮颜色
    ///   - action: 按钮事件
    /// - Returns: 按钮
    @objc class func action(title:String,bgImageName:String?,titleColor:UIColor?=RGB(r: 30, g: 144, b: 255),action:(() -> Void)? = nil) -> HPCustomAlertAction{
        var textColor = titleColor
        if textColor==nil {
            textColor = RGB(r: 30, g: 144, b: 255)
        }
        return HPCustomAlertAction(title: title, bgImageName: bgImageName, titleColor: textColor, action: action)
    }
    
    fileprivate func createButton(textColor:UIColor?,backgroundColor:UIColor?,bgImageName:String?,title:String,action:(() -> Void)? = nil) -> UIButton {
        let tmp = UIButton(type: .custom)
        tmp.setTitleColor(textColor, for: .normal)
        tmp.backgroundColor = backgroundColor
        tmp.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        tmp.setTitle(title, for: .normal)
        if let bgImageName = bgImageName {
            tmp.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        }
        clickAction = action
        if ((action) != nil) {
            tmp .addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        }
        return tmp
    }
    
    @objc fileprivate func buttonClick(sender:UIButton) {
        alertController?.dismiss(animated: true, completion: nil)
        clickAction?()
    }
}
