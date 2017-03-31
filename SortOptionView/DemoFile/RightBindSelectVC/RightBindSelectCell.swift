//
//  RightBindingSelectCell.swift
//  YDTX
//
//  Created by Story5 on 3/17/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

import UIKit
import SVProgressHUD

class RightBindSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var bindCountLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    func updateView(with rightBindModel : RightBindPondModel) -> Void {
        //        return
        
        let bindedString = "\(rightBindModel.bind_num)"
        let text = bindedString + "/" + "\(rightBindModel.bind_totalnum)"
        updateLabel(bindedString: bindedString, text: text)
        
        let rightBindPondModel : RightBindPondModel = rightBindModel 
        updatePondView(rightBindPondModel: rightBindPondModel)
    }
    
    func updatePondView(rightBindPondModel:RightBindPondModel) -> Void {
        let nibView = Bundle.main.loadNibNamed("RightBindPondView", owner: nil, options: nil)
        let pondView : RightBindPondView = nibView?.first as! RightBindPondView
        pondView.configureData(rightBindPondModel)
        rightView.addSubview(pondView)
    }
    
    func updateLabel(bindedString:String,text:String) -> Void {
        let attributedText = NSMutableAttributedString(string: text as String)
        
        let allRange = NSMakeRange(0, text.characters.count)
        let range = NSMakeRange(0, bindedString.characters.count)
        let color = UIColor(red: 255, green: 128, blue: 0, alpha: 1)
        
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: allRange)
        attributedText.addAttribute(NSForegroundColorAttributeName, value: color, range:range)
        
        bindCountLabel.attributedText = attributedText
    }
}
