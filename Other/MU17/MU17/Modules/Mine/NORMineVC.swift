//
//  NORMineVC.swift
//  MU17
//
//  Created by nor on 2020/10/27.
//

import UIKit

class NORMineVC: NORBaseVC {

    private lazy var myArray: Array = {
        return [
            [
                ["icon": "mine_vip", "title": "我的VIP"],
                ["icon": "mine_coin", "title": "充值妖气币"],
            ],
            
            [
                ["icon": "mine_accout", "title": "消费记录"],
                ["icon": "mine_subscript", "title": "我的订阅"],
                ["icon": "mine_seal", "title": "我的封印图"],
            ],
            
            [
                ["icon": "mine_message", "title": "我的消息/优惠卷"],
                ["icon": "mine_cashew", "title": "妖果商城"],
                ["icon": "mine_freed", "title": "在线阅读免流量"],
            ],
            
            [
                ["icon": "mine_feedBack", "title": "帮助中心"],
                ["icon": "mine_mail", "title": "我要反馈"],
                ["icon": "mine_judge", "title": "给我们评分"],
                ["icon": "mine_author", "title": "成为作者"],
                ["icon": "mine_setting", "title": "设置"],
            ],
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 修改 statusbar 颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}
