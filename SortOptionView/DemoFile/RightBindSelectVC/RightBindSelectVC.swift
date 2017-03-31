//
//  RightBindingSelectVC.swift
//  YDTX
//
//  Created by Story5 on 3/17/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

import UIKit
import AFNetworking
import MJRefresh

enum DealRequestData : Int {
    case none       = 0
    case clearData  = 1
    case appendData = 2
}

class RightBindSelectVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,SortOptionViewDataSource,SortOptionViewDelegate {
    
    @IBOutlet weak var filterMainView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewData : Array<RightBindPondModel> = Array()
    
    
    fileprivate var _page : Int = 1
    fileprivate var page : Int{
        set {
            _page = newValue
            self.requestDealData = .appendData
        }
        get {
            return _page
        }
    }
    
    private var keyword : Int = 1

    fileprivate var requestDealData = DealRequestData.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "item2"
        collectionView.register(UINib.init(nibName: "RightBindSelectCell", bundle: Bundle.main), forCellWithReuseIdentifier: "rightBindSelectCell")
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.requestData()
        })
        
        self.createFilter()
        
        self.page = 1;
        
        requestData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let rightBindSelectCell : RightBindSelectCell = collectionView .dequeueReusableCell(withReuseIdentifier: "rightBindSelectCell", for: indexPath) as! RightBindSelectCell
        let rightBindModel = self.collectionViewData[indexPath.row]
        rightBindSelectCell.updateView(with: rightBindModel)
        
        return rightBindSelectCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }
    
    // MARK: - request Data
    func requestData() -> Void {
        
        if self.requestDealData == .clearData {
            self.collectionViewData.removeAll()
        }
        
        NetWorkService.shareInstance()?.request(withParam: getParam(), success: { (task, modelArray) in
            for index in 0...(modelArray?.count)!-1 {
                let modelDic = modelArray?[index]
                let rightBindModel = RightBindPondModel.yy_model(with: modelDic as! [AnyHashable : Any])
                self.collectionViewData.append(rightBindModel!)
            }
            self.collectionView.reloadData()
            if self.page == 1 {
                self.collectionView.contentOffset = CGPoint.zero
            }
            self.collectionView.mj_footer.endRefreshing()
            
        }, failure: { (error) in
            self.collectionView.mj_footer.endRefreshingWithNoMoreData()

        })
    }
    
    func getParam() -> [String:Any] {
        
        let param = ["page"     : self.page,
                     "keyword"  : self.keyword,
                     "lng"      : 0,
                     "lat"      : 0]
        return param;
    }
    
    // MARK: - createUI
    func createFilter() -> Void {
        
        let sortOptionView : SortOptionView = SortOptionView()
        sortOptionView.frame = self.filterMainView.bounds
        sortOptionView.dataSource = self
        sortOptionView.delegate = self
        self.filterMainView.addSubview(sortOptionView);
        
        sortOptionView.titleFont = UIFont.systemFont(ofSize: 15)
        let titleNormalColor = UIColor(red: 83 / 255.0, green: 83 / 255.0, blue: 83 / 255.0, alpha: 1.0)
        let titleSelectedColor = UIColor(red: 1, green: 128 / 255.0, blue: 0, alpha: 1.0)
        let seperateColor = UIColor(red: 222 / 255.0, green: 222 / 255.0, blue: 222 / 255.0, alpha: 1)
        sortOptionView.titleNormalColor = titleNormalColor
        sortOptionView.titleSelectedColor = titleSelectedColor
        sortOptionView.seperateLineColor = seperateColor
        sortOptionView.show()
    }
    
    // MARK: - SortOptionViewDataSource
    func titleArray(for sortOptionView: SortOptionView!) -> [Any]! {
        return ["离我最近","绑定人数","鱼情"]
    }
    
    func imageShowStatusArray(for sortOptionView: SortOptionView!) -> [Any]! {
        return ["0","1","1"]
    }
    
    // MARK: - SortOptionViewDelegate
    func sortOptionView(_ sortOptionView: SortOptionView!, didClickedItemAt index: UInt, sortOption: SortOptionType) {
        
        self.page = 1
        // 塘口 : 0_离我最近(1)  - 1_绑定人数(4,5) - 2_鱼情(2,3)
        let paramArray = [[1,1],[4,5],[2,3]]
        let x = Int(index)
        let y = Int(sortOption.rawValue) - 1
        let param = paramArray[x][y]
        self.keyword = param
        self.requestDealData = .clearData
        self.requestData()
    }
    
}
