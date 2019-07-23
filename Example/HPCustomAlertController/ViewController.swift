//
//  ViewController.swift
//  HPCustomAlertController
//
//  Created by hpzerozero on 03/29/2019.
//  Copyright (c) 2019 hpzerozero. All rights reserved.
//

import UIKit
import SnapKit
import SnapkitArrayExtention
import HCPCustomAlertController
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RGB(r: 238, g: 238, b: 238)
        let alertC = HPCustomAlertController(title: "警告", message: "这是一个弹窗，提示你一些事情", iconName: nil)
        alertC.add(action: HPCustomAlertAction(title: "取消", bgImageName: nil, titleColor: nil, action: {
            print("取消")
        }))
        alertC.add(action: HPCustomAlertAction(title: "确定", bgImageName: nil, titleColor: nil, action: {
            print("确定")
        }))
//        alertC.show(aViewController: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let alertC2 = HPCustomAlertController(title: "警告", titleColor: RGB(r: 255, g: 80, b: 0), message: "这是一个弹窗，提示你一些事情这是一个弹窗，提示你一些事情这是一个弹窗，提示你一些事情这是一个弹窗，提示你一些事情", iconName: nil, buttonEdgeInsets: .zero)
//        alertC2.dimBackground = false
        alertC2.add(action: HPCustomAlertAction(title: "取消", backgroundColor: nil, bgImageName: nil, titleColor: RGB(r: 53, g: 53, b: 53), buttonStyle: .rectangleFill, action: {
            print("取消")
        }))
        alertC2.add(action: HPCustomAlertAction(title: "确定", backgroundColor: RGB(r: 28, g: 164, b: 96), bgImageName: nil, titleColor: RGB(r: 255, g: 255, b: 255), buttonStyle: .rectangleFill, action: {
            print("确定")
        }))
        alertC2.show(aViewController: self)
    }
}

