//
//  Drawer.swift
//  BarkisWallet
//
//  Created by YanYi on 2020/2/21.
//  Copyright © 2020 YanYi. All rights reserved.
//

import UIKit

/// 抽屉弹出位置
enum Stick {
    // 屏幕左边
    case leading
    // 屏幕右边
    case trailing
}

class Drawer: UIView {
    
    /// 屏幕宽度
    static let ScreenHeight = UIScreen.main.bounds.height
    /// 屏幕高度
    static let ScreenWidth = UIScreen.main.bounds.width
    /// 屏幕比例
    static let Scale = UIScreen.main.scale

    /// 承载抽屉内容的View
    var contentView: UIView = UIView()
    
    /// 抽屉弹出方向
    var stick: Stick = .leading
    
    /// 抽屉是否已经显示
    var isShow: Bool = false
    
    /// 抽屉动画时长
    var duration: TimeInterval = 0.2
    
    /// 抽屉内容frame
    private var _contentFrame: CGRect = CGRect(x: 0, y: 0, width: ScreenWidth * 3 / 5, height: ScreenHeight)
    var contentFrame: CGRect {
        set {
            _contentFrame = newValue
            switch stick {
            case .leading:
                contentView.frame = CGRect(x: _contentFrame.origin.x, y: _contentFrame.origin.y, width: _contentFrame.width, height: _contentFrame.height)
            case .trailing:
                contentView.frame = CGRect(x: _contentFrame.origin.x , y: _contentFrame.origin.y, width: _contentFrame.width, height: _contentFrame.height)
            }
        }
        
        get {
            return _contentFrame
        }
    }
    
    
    /// 初始化抽屉
    /// - Parameters:
    ///   - contentFrame: 抽屉内容初始frame
    ///   - aStick: 抽屉弹出的方向
    ///   - aDuration: 抽屉弹出与关闭的动画时长
    init(contentFrame: CGRect, _ aStick: Stick, _ aDuration: TimeInterval) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        stick = aStick
        duration = aDuration
        self.contentFrame = contentFrame
        contentView.backgroundColor = .white
        addSubview(contentView)
        alpha = 0
        let hideTap = UITapGestureRecognizer.init(target: self, action: #selector(hideDrawer))
        hideTap.numberOfTouchesRequired = 1
        hideTap.numberOfTapsRequired = 1
        addGestureRecognizer(hideTap)
        
        let nothingTap = UITapGestureRecognizer.init(target: self, action: #selector(nothing))
        nothingTap.numberOfTouchesRequired = 1
        nothingTap.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(nothingTap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nothing() {
        
    }
    
    @objc func showDrawer() {
        UIApplication.shared.windows[0].addSubview(self)
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
            self.openContent()
        }) { (compleated) in
            
        }
        isShow = true
    }
    
    @objc func hideDrawer() {
        UIView.animate(withDuration: duration, animations: {
            self.closeContent()
        }) { (compleated) in
            self.removeFromSuperview()
        }
        isShow = false
    }
    
    /// 关闭内容
    @objc private func openContent() {
        switch stick {
        case .leading:
            contentFrame = CGRect(x: 0, y: _contentFrame.origin.y, width: _contentFrame.width, height: _contentFrame.height)
        case .trailing:
            contentFrame = CGRect(x: Drawer.ScreenWidth - _contentFrame.width, y: _contentFrame.origin.y, width: _contentFrame.width, height: _contentFrame.height)
        }
    }
    
    /// 打开内容
    @objc private func closeContent() {
           switch stick {
           case .leading:
               contentFrame = CGRect(x: -_contentFrame.width, y: _contentFrame.origin.y, width: _contentFrame.width, height: _contentFrame.height)
           case .trailing:
            contentFrame = CGRect(x: Drawer.ScreenWidth, y: _contentFrame.origin.y, width: _contentFrame.width, height: _contentFrame.height)
           }
    }
}
