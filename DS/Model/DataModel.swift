//
//  VideoInfo.swift
//  DS
//
//  Created by langyue on 15/12/22.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit

class VideoInfo: NSObject {
    
    let id: String
    let title: String
    let pic: String
    let url: String
    let cTime: String
    let isCollectStatus : Int
    
    
    init(id:String,title:String,pic: String,url: String,cTime: String,isCollectStatus: Int) {
        
        self.id = id
        self.title = title
        self.pic = pic
        self.url = url
        self.cTime = cTime
        self.isCollectStatus = isCollectStatus
        
    }
    
    override init() {
        self.id = ""
        self.title = ""
        self.pic = ""
        self.url = ""
        self.cTime = ""
        self.isCollectStatus = 0
    }

}



public class User: NSObject {
    
    var id:Int = 0
    var nickName : String = ""
    var password : String = ""
    var headImage : String = ""
    var phone: String = ""
    var gender : Int = 0
    var platformId:String = ""
    var platformName: String = ""
    
    init(id:Int,nickName:String,password:String,headImage:String,phone:String,gender:Int,platformId:String,platformName:String){
        
        self.id = id
        self.nickName = nickName
        
        self.password = password
        self.headImage = headImage
        self.phone = phone
        self.gender = gender
        self.platformId = platformName
        self.platformName = platformName
        
    }
    
    override init(){
        super.init()
        self.id = 0
        self.nickName = ""
        self.password = ""
        self.headImage = ""
        self.phone = ""
        self.gender = 0
        self.platformId = ""
        self.platformName = ""
    }
   
}



class UserFavorite : NSObject{
    
    
    let id: Int
    let userId: Int
    let videoId: String
    let status: Int
    
    init(id: Int, userId: Int,videoId: String,status:Int) {
        self.id = id
        self.userId = userId
        self.videoId = videoId
        self.status =  status
    }
    
}



class ResponseEntity {
    
    let message: String
    let content: AnyObject
    let request: String
    let status: Int
    
    
    init(message: String,content:AnyObject,request:String,statusCode:Int){
        
        self.message = message
        self.content = content
        self.request = request
        self.status = statusCode
        
    }
    
}





class DataCenter: NSObject {
    
    
    class var shareDataCenter:DataCenter{
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance: DataCenter? = nil
        }
        dispatch_once(&Static.onceToken){() -> Void in
            Static.instance = DataCenter()
        }
        return Static.instance!
    }
    
    
    var user:User = User()
    
    func getVideosFromType(type:Int) -> [VideoInfo]{
        
        switch type{
            
        case 0:
            return videoInfos
        case 1:
            return videoInfosFromHot
        case 2:
            return videoInfosFromPop
        default:
            return[]
            
        }
        
        
    }
    
    
    
    
    var videoInfos:[VideoInfo] = [VideoInfo]()
    
    var videoInfosFromHot:[VideoInfo] = [VideoInfo]()
    
    var videoInfosFromPop:[VideoInfo] = [VideoInfo]()
    
    
    
    var videoInfo:VideoInfo = VideoInfo()
    
    struct paramModel {
        
        var videoUrlString = ""
        var videoTitleLabel = ""
        var videoInfoLabel = ""
        var videoPic = ""
        var videoId = ""
        
    }
    
        
}













