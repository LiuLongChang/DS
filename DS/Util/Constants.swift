//
//  Constants.swift
//  DS
//
//  Created by langyue on 15/12/22.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import Kingfisher


var loginState:Bool = false

var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

let user = userDefaults.objectForKey("userInfo")


var alamofireManager : Manager = Manager.sharedInstanceAndTimeOut




//字号颜色#797979

//定位 字号加大

//年检验车。。最新活动：      改成图片 字体幼圆

//返回按钮变成系统的BUG

//左导航按钮左调整 仿安卓