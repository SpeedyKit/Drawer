//
//  HomeViewController.swift
//  Drawer
//
//  Created by YanYi on 2020/2/23.
//  Copyright © 2020 YanYi. All rights reserved.
//

import UIKit


let plainCellId: String = "plainCellId"
let gridCellId: String = "gridCellId"

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,HomePageFlowLayoutDelegate {
   
    /// 屏幕宽度
    static let ScreenHeight = UIScreen.main.bounds.height
    /// 屏幕高度
    static let ScreenWidth = UIScreen.main.bounds.width
    /// 屏幕比例
    static let Scale = UIScreen.main.scale
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var layoutType: LayoutType = .plain
    weak var layout : HomePageFlowLayout?
    var cellId: String = plainCellId
    let dataManager = HomePageDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
    }
    
    func initSubViews() {
        navigationItem.title = "抽屉类型"
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "切换布局", style: .plain, target: self, action: #selector(switchLayoutType))
        layout = (myCollectionView.collectionViewLayout as! HomePageFlowLayout)
        layout!.type = .plain
        layout?.delegate = self
        myCollectionView.register(UINib.init(nibName: "HomePagePlainCVCell", bundle: .main), forCellWithReuseIdentifier: plainCellId)
        dataManager.configDataSource()
        myCollectionView.reloadData()
    }
    
    @objc func switchLayoutType() {
        switch layoutType {
        case .plain:
            layoutType = .grid
            break
        case .grid:
            layoutType = .plain
            break
        }
        layout?.type = layoutType
        myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePagePlainCVCell
        cell.updateUI(dataManager.dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(layout collectionViewLayout: HomePageFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch layoutType {
        case .plain:
//            return CGSize(width: HomeViewController.ScreenWidth - 20, height: HomeViewController.ScreenWidth * 0.6)
            return CGSize(width: HomeViewController.ScreenWidth, height: 60)
        case .grid:
            return CGSize(width: (HomeViewController.ScreenWidth - 30) / 2, height: (HomeViewController.ScreenWidth - 30) / 2 / 0.6)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataManager.dataSource[indexPath.row]
        switch model.drawerStype {
        case .base:
            navigationController?.pushViewController(BaseStyleExampleViewController(), animated: true)
        }
    }

}

class HomePageDataManager: NSObject {
    var dataSource:[HomePageDataModel] = []
    func configDataSource()  {
        let baseStyle = HomePageDataModel()
        dataSource.append(baseStyle)
    }
}



class HomePageDataModel: NSObject {
    var name: String = "基础样式"
    var drawerStype: DrawerStyle = .base
}
