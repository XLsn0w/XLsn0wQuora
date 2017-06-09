//
//  UserModel.swift
//  小礼品
//
//  Created by 李莎鑫 on 2017/4/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var id: Int = 0
    //: 用户id
    var uid: String?
    //: 昵称
    var nickname:String?
    //: 头像url地址
    var avatarUrl:String?
    //: 头像本地地址
    var avatarLoc:String?
    //: 心情寄语
    var say:String?
    //: 性别
    var sex: Int = 0
}
