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
        let alertC = HPCustomAlertController(title: "警告", message: "这是一个弹窗，提示你一些事情", iconName: nil)
        alertC.add(action: HPCustomAlertAction(title: "取消", bgImageName: nil, titleColor: nil, action: {
            print("取消")
        }))
        alertC.add(action: HPCustomAlertAction(title: "确定", bgImageName: nil, titleColor: nil, action: {
            print("确定")
        }))
        alertC.show(aViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

