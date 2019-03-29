//
//  Theme.swift
// HPBaseApp
//
//  Created by hp on 2016/11/3.
//  Copyright © 2016年 hpone. All rights reserved.
//

import UIKit
// MARK: 定义屏幕的尺寸全局变量
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_SIZE = UIScreen.main.bounds.size
let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_MIN = min(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MAX = max(SCREEN_WIDTH, SCREEN_HEIGHT)
// MARK: 颜色
func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}
//let MainColor = UIColor.init(hexString: "#3489FF")!
let RGB51 = RGB(r: 51, g: 51, b: 51)
let RGB245 = RGB(r: 245, g: 245, b: 245)
let RGB153 = RGB(r: 153, g: 153, b: 153)


