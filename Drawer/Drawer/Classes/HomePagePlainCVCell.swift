//
//  HomePagePlainCVCell.swift
//  Drawer
//
//  Created by YanYi on 2020/2/24.
//  Copyright © 2020 YanYi. All rights reserved.
//

import UIKit

class HomePagePlainCVCell: UICollectionViewCell {

    @IBOutlet weak var contentBGView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentBGView.setShadow(width: 0, bColor: .clear, sColor: .lightGray, offset: CGSize(width: 0, height: 3), opacity: 0.6, radius: 3)
    }
    
    func updateUI(_ model: HomePageDataModel) {
        nameLabel.text = model.name
    }
    
}
