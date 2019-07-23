//
//  ViewController.swift
//  HPCustomAlertController
//
//  Created by hpzerozero on 03/29/2019.
//  Copyright (c) 2019 hpzerozero. All rights reserved.
//

import UIKit
//import SnapKit
//import SnapkitArrayExtention
//import HCPCustomAlertController
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = RGB(r: 238, g: 238, b: 238)
//        let alertC = HPCustomAlertController(title: "警告", message: "这是一个弹窗，提示你一些事情", iconName: nil)
//        alertC.add(action: HPCustomAlertAction(title: "取消", bgImageName: nil, titleColor: nil, action: {
//            print("取消")
//        }))
//        alertC.add(action: HPCustomAlertAction(title: "确定", bgImageName: nil, titleColor: nil, action: {
//            print("确定")
//        }))
//        alertC.show(aViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alertC2 = HPCustomAlertController(title: "警告", titleColor: RGB(r: 255, g: 80, b: 0), message: "这是一个弹窗，提示你一些事情这是一个弹窗，提示你一些事情这是一个弹窗，提示你一些事情这是一个弹窗，提示你一些事情", iconName: nil, buttonEdgeInsets: UIEdgeInsets(top: 7, left: 20, bottom: 7, right: 20),alertStyle: .actionSheet)
//        alertC2.dimBackground = false
        
        alertC2.add(action: HPCustomAlertAction(title: "确定", backgroundColor: RGB(r: 28, g: 164, b: 96), bgImageName: nil, titleColor: RGB(r: 255, g: 255, b: 255), buttonStyle: .archFill, action: {
            print("确定")
        }))
        alertC2.add(action: HPCustomAlertAction(title: "查看具体技巧>", backgroundColor: nil, bgImageName: nil, titleColor: RGB(r: 28, g: 164, b: 96), buttonStyle: .noneBackground, action: {
            print("取消")
        }))
//        alertC2.show(aViewController: self)
        let content = UIView(frame: .zero)
        let label = createLabel(color: RGB(r: 28, g: 164, b: 96), alignment: .center, font: UIFont.systemFont(ofSize: 16, weight: .bold))
        label.text = "- 自助小技巧 -"
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "IMG_C8E151F1CE14-1.jpg")
        content.addSubview(label)
        content.addSubview(imageView)
        label.snp.makeConstraints { (maker) in
            maker.top.equalTo(20)
            maker.left.right.equalToSuperview()
        }
        imageView.snp_makeConstraints { (maker) in
            maker.top.equalTo(label.snp.bottom).offset(20)
            maker.left.equalTo(20)
            maker.right.equalTo(-20)
            maker.bottom.equalTo(0)
            maker.width.equalTo(imageView.snp.height).multipliedBy(1.5)
        }
        
        let alertC3 = HPCustomAlertController(custom: content, buttonEdgeInsets: UIEdgeInsets(top: 7, left: 20, bottom: 7, right: 20), alertStyle: .actionSheet)
        
        alertC3.add(action: HPCustomAlertAction(title: "确定", backgroundColor: RGB(r: 28, g: 164, b: 96), bgImageName: nil, titleColor: RGB(r: 255, g: 255, b: 255), buttonStyle: .archFill, action: {
            print("确定")
        }))
        let attribute = NSMutableAttributedString(string: "查看具体技巧>",
                                                  attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),
                                                               .underlineStyle:NSUnderlineStyle.styleSingle.rawValue,
                                                               .underlineColor:RGB(r: 28, g: 164, b: 96),
                                                               .foregroundColor:RGB(r: 28, g: 164, b: 96)])
        alertC3.add(action: HPCustomAlertAction(title: "",attribute, backgroundColor: nil, bgImageName: nil, titleColor: RGB(r: 28, g: 164, b: 96), buttonStyle: .noneBackground, action: {
            print("取消")
        }))
        alertC3.show(aViewController: self)
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

