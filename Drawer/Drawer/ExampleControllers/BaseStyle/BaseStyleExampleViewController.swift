//
//  BaseStyleExampleViewController.swift
//  Drawer
//
//  Created by YanYi on 2020/2/24.
//  Copyright © 2020 YanYi. All rights reserved.
//

import UIKit

class BaseStyleExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func openLeftDrawer(_ sender: Any) {
        let drawer = Drawer.init(contentFrame: CGRect(x: -Drawer.ScreenWidth * 0.8, y: 0, width: Drawer.ScreenWidth * 0.8, height: Drawer.ScreenHeight), .leading, 0.2)
        drawer.showDrawer()
        
    }
    
    @IBAction func openRightDrawer(_ sender: Any) {
        let drawer = Drawer.init(contentFrame: CGRect(x: Drawer.ScreenWidth, y: 0, width: Drawer.ScreenWidth * 0.8, height: Drawer.ScreenHeight), .trailing, 0.2)
        drawer.showDrawer()
        
    }
    
}
