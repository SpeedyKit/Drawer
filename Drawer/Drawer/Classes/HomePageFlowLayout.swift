//
//  HomePageFlowLayout.swift
//  Drawer
//
//  Created by YanYi on 2020/2/23.
//  Copyright © 2020 YanYi. All rights reserved.
//

import UIKit

enum LayoutType {
    case grid       // 宫格
    case plain      // 正常
}

protocol HomePageFlowLayoutDelegate: class {
    func collectionView(layout collectionViewLayout: HomePageFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
}

class HomePageFlowLayout: UICollectionViewFlowLayout {
    var attributesArray : [UICollectionViewLayoutAttributes] = []
    var type: LayoutType = .plain
    weak var delegate: HomePageFlowLayoutDelegate?
    var contentHeight: CGFloat = 0
    override func prepare() {
        let count = collectionView?.dataSource?.collectionView(collectionView!, numberOfItemsInSection: 0)
          attributesArray.removeAll()
          if count! > 0 {
              for index in 0...(count! > 0 ? count! - 1 : 0){
                  let attributes = layoutAttributesForItem(at: IndexPath.init(item: index, section: 0))
                  attributesArray.append(attributes!)
              }
          }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribuites = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        let size:CGSize = (delegate?.collectionView(layout: self, sizeForItemAt: indexPath))!
        let plainSpace:CGFloat = (UIScreen.main.bounds.width - size.width) / 2
        switch type {
        case .plain:
            attribuites.frame = CGRect(x: plainSpace, y: 10 + (size.height + 10) * CGFloat(indexPath.row), width: size.width, height: size.height)
            contentHeight = 10 + (size.height + 10) * CGFloat(indexPath.row + 1)
        case .grid:
            attribuites.frame = CGRect(x: 10 + (size.width + 10) * CGFloat(indexPath.row % 2), y: (size.height + 10) * CGFloat(indexPath.row / 2), width: size.width, height: size.height)
            contentHeight = (size.height + 10) * CGFloat((indexPath.row + 1) / 2 + (indexPath.row + 1) % 2)
        }

        return attribuites
    }
    
    
    override var collectionViewContentSize: CGSize {
        contentHeight = contentHeight < (collectionView?.frame.height)! ? (collectionView?.frame.height)! : contentHeight
        return CGSize(width: (collectionView?.bounds.width)! , height: contentHeight)
    }
    
}
