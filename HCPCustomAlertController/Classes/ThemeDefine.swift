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
public func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}
//let MainColor = UIColor.init(hexString: "#3489FF")!
let RGB51 = RGB(r: 51, g: 51, b: 51)
let RGB245 = RGB(r: 245, g: 245, b: 245)
let RGB153 = RGB(r: 153, g: 153, b: 153)

/// 判断是否是暗黑模式
func hp_isDarkMode() -> Bool {
    var isDarkMode = false
    if #available(iOS 13.0, *) {
        isDarkMode = UITraitCollection.current.userInterfaceStyle == UIUserInterfaceStyle.dark
    }
    return isDarkMode
    
    
}

extension UIColor {
    class var colorBgW: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.systemBackground
                } else {
                    return UIColor.white
                }
            })
        } else {
            color = UIColor.white
        }
        return color
    }
    class var colorBgB: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.tertiarySystemBackground
                } else {
                    return UIColor.black
                }
            })
        } else {
            color = UIColor.black
        }
        return color
    }
    class var colorW: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.label
                } else {
                    return UIColor.white
                }
            })
        } else {
            color = UIColor.white
        }
        return color
    }
    
    class var color245: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.quaternaryLabel
                } else {
                    return RGB245
                }
            })
        } else {
            color = RGB245
        }
        return color
    }
    class var color153: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.tertiaryLabel
                } else {
                    return RGB153
                }
            })
        } else {
            color = RGB153
        }
        return color
    }
    
    class var color106: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.secondaryLabel
                } else {
                    return RGB(r: 106, g: 106, b: 106)
                }
            })
        } else {
            color = RGB(r: 106, g: 106, b: 106)
        }
        return color
    }
    
    class var color51: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.secondaryLabel
                } else {
                    return RGB51
                }
            })
        } else {
            color = RGB51
        }
        return color
    }
    
    class var colorB: UIColor {
        var color:UIColor!
        if #available(iOS 13.0, *) {
            color = UIColor(dynamicProvider: { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.label
                } else {
                    return UIColor.black
                }
            })
        } else {
            color = UIColor.black
        }
        return color
    }
}
