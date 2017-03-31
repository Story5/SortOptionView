//
//  RightBindingPondView.swift
//  YDTX
//
//  Created by RookieHua on 2017/3/25.
//  Copyright © 2017年 RookieHua. All rights reserved.
//

import UIKit

class RightBindPondView: UIView {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pondLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    func configureData(_ pondModel:RightBindPondModel) ->Void {
     
        //塘口名称
        pondLabel.text = pondModel.theme
        //价格
        if (pondModel.price != nil) {
            priceLabel.text = pondModel.price
        }
        //距离
        let distance = pondModel.juli
        if (distance < 1.0) {
            distanceLabel.text = String(format: "据您%.2f米", distance * 100)
        } else {
            distanceLabel.text = String(format: "据您%.2f公里", distance)
        }
        //塘口图片
        if (pondModel.big_img != nil) {
            let url = URL(string: "https://test.m.yundiaoke.cn" + pondModel.big_img!);
            imgView.yy_setImage(with: url, options: .progressive)
        }
    }
}
