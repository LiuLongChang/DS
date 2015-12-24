//
//  HttpController.swift
//  DS
//
//  Created by langyue on 15/12/23.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation


protocol HttpProtocol{
    func didReceiveResults(results:AnyObject)
}



class HttpController: NSObject {
    
    
    var delegate: HttpProtocol?
    
    func onDSResource(urlRequestConvertible:URLRequestConvertible){
        
        Alamofire.request(urlRequestConvertible).responseJSON { response in
            if let JSON = response.result.value {
                self.delegate?.didReceiveResults(JSON)
            }else{
                
            }
        }
        
    }
    
    
    
    class func getVideos(urlRequestConvertible:URLRequestConvertible,callback:[VideoInfo]?->Void){
        alamofireManager.request(urlRequestConvertible).responseJSON { (response) -> Void in
            
            switch response.result{
                
            case .Success:
                
                if response.response?.statusCode == 200 {
                    
                    if let JSON = response.result.value{
                        let videoInfos:[VideoInfo]
                        videoInfos = ((JSON as! NSDictionary).valueForKey("content") as! [NSDictionary]).map{
                            VideoInfo(id: $0["id"] as! String, title: $0["title"] as! String, pic: $0["pic"] as! String, url: $0["videoUrl"] as! String, cTime: $0["pushTime"] as! String, isCollectStatus: $0["isCollectStatus"] as! Int)
                        }
                        
                        
                        callback(videoInfos)
                    }
                    
                }else{
                    callback(nil)
                }
                
            case .Failure(let error):
                print(error)
                callback(nil)
                
            }
        }
    }
    
    
    
    
    
    class func getVideoById(urlRequestConvertible:URLRequestConvertible,callback:VideoInfo?->Void){
        
        alamofireManager.request(urlRequestConvertible).responseJSON { (response) -> Void in
            
            switch response.result{
                
            case .Success:
                
                if response.response?.statusCode == 200 {
                    
                    if let JSON = response.result.value{
                        
                        let videoDict = (JSON as! NSDictionary).valueForKey("content") as! NSDictionary
                        
                        let videoInfo = VideoInfo(id: videoDict["id"] as! String, title: videoDict["title"] as! String, pic: videoDict["pic"] as! String, url: videoDict["videoUrl"] as! String, cTime: videoDict["pushTime"] as! String, isCollectStatus: videoDict["isCollectStatus"] as! Int)
                    
                        callback(videoInfo)
                    }
                }else{
                    callback(nil)
                }
                
            case .Failure(let error):
                print(error)
                callback(nil)
            }
            
        }
        
    }
    
    
    
    
    class func onUserAndMovie(urlRequestConvertible:URLRequestConvertible,callback:Int?->Void){
        
        alamofireManager.request(urlRequestConvertible).responseJSON { (response) -> Void in
            
            switch response.result{
            case .Success:
                let statusCode = response.response?.statusCode
                if statusCode == 201 || statusCode == 200 {
                    callback(statusCode)
                }else{
                    callback(0)
                }
                
            case .Failure(let error):
                print(error)
                callback(0)
                
            }
            
        }
        
        
    }
    
    
    
    
    
    class func onUser(urlRequestConvertible:URLRequestConvertible,callback:User?->Void){
        
        alamofireManager.request(urlRequestConvertible).responseJSON { (response) -> Void in
            
            switch response.result{
                
            case .Success:
                let statusCode = response.response?.statusCode
                if statusCode == 201 || statusCode == 200 {
                    
                    if let JSON = response.result.value {
                        let userDictionary = (JSON as! NSDictionary).valueForKey("content") as! NSDictionary
                        userDefaults.setObject(userDictionary, forKey: "userInfo")
                        let userInfo = User(id: userDictionary["id"] as! Int, nickName: userDictionary["nickName"] as! String, password: "", headImage: userDictionary["headImage"] as! String, phone: userDictionary["phone"] as! String, gender: userDictionary["gender"] as! Int, platformId: userDictionary["platformId"] as! String, platformName: userDictionary["platformName"] as! String)
                        
                        DataCenter.shareDataCenter.user = userInfo
                        
                        
                    }
                    
                    
                }else{
                    callback(nil)
                }
                
            case .Failure(let error):
                print(error)
            
            }
           
        }
    }
}


extension Alamofire.Manager{
    
    static let sharedInstanceAndTimeOut: Manager = {
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 10
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        return Manager(configuration: configuration)
        
    }()
    
}


struct HttpClientByVideo {
    
    
    enum DSRouter: URLRequestConvertible{
        
        static let baseURLString = "https://api.doushi.me/v1/rest/video/"
        
        case VideosByType(Int,Int,Int,Int)//get video info by type
        case getVideosByBanner(Int) // get banner video
        case getVideoTaxis(Int)//get ranks
        case getVideosById(String,Int)//get video info by id
        
        
        var method: Alamofire.Method {
            switch self{
             
            case .VideosByType:
                return .GET
            case .getVideosByBanner:
                return .GET
            case .getVideoTaxis:
                return .GET
            case .getVideosById:
                return .GET
        
            }
        }
        
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
               
                switch self{
                
                case .VideosByType(let vid, let count, let type, let userId):
                    return ("getVideosByType/\(vid)/\(count)/\(type)/\(userId)")
                case .getVideosByBanner(let userId):
                    return "getVideosByBanner/\(userId)"
                case .getVideoTaxis(let userId):
                    return "getVideoTaxis/\(userId)"
                case .getVideosById(let videoId,let userId):
                    return "getVideosById/\(videoId)/\(userId)"
                }
                
            }()
            
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            
            
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
            
            
        }
        
    }

}




struct HttpClientByUser{
    
    
    enum DSRouter: URLRequestConvertible {
        
        static let baseURLString = "https://api.doushi.me/v1/rest/user/"
        
        
        case registerUser(User)//注册用户
        case loginUser(String,String)//用户登录
        
        
        
        var method: Alamofire.Method {
            switch self {
            case .registerUser:
                return .POST
            case .loginUser:
                return .GET
            }
        }
        
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                switch self {
                
                case .registerUser(_):
                    return "registerUser"
                case .loginUser(let phone, let password):
                    return "loginUser/\(phone)/\(password)"
                }
                
            }()
            
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            
            
            
            switch self{
            case .registerUser(let user):
                URLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                //
                let parameters = ["nickName":user.nickName,"headImage":user.headImage,"phone":user.phone,"platformId":user.platformId,"platformName":user.platformName,"password":user.password,"gender":user.gender]
                do {
                    
                    URLRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
                    
                } catch {
                    
                }
                
            default: break
               
            }
            
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
            
        }
       
    }
    
}


struct HttpClientByUtil {
    
    enum DSRouter: URLRequestConvertible{
        
        static let baseURLString = "https://api.doushi.me/v1/rest/util/"
        
        case getQiNiuUpToken()
        
        
        var method: Alamofire.Method {
            switch self{
            case .getQiNiuUpToken():
                return .GET
            }
        }
        
        var URLRequest : NSMutableURLRequest{
            
            let (path) : String = {
                switch self {
                case .getQiNiuUpToken():
                    return ("getQiNiuUpToken")
                }
            }()
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
            
        }
    }
}



struct HttpClientByUserAndVideo {
    
    enum DSRouter: URLRequestConvertible {
        
        static let baseURLString = "https://api.doushi.me/v1/rest/userAndVideo/"
        
        
        case deleteByUserIdAndVideoId(Int,String)
        case addUserFavoriteVideo(UserFavorite)
        case getVideosByUserId(Int,Int,Int)
        
        
        
        var method: Alamofire.Method {
            switch self{
            case .deleteByUserIdAndVideoId:
                return .DELETE
            case .addUserFavoriteVideo:
                return .POST
            case .getVideosByUserId:
                return .GET
            }
        }
        
        
        
        var URLRequest: NSMutableURLRequest {
            
            let (path) : (String) = {
                switch self{
                case .getVideosByUserId(let userId, let pageNum, let count):
                    return ("getVideoByUserId/\(userId)/\(pageNum)/\(count)")
                case .deleteByUserIdAndVideoId(let userId, let vid):
                    return ("deleteByUserIdAndVideoId/\(userId)/\(vid)")
                case .addUserFavoriteVideo(_):
                    return "addUserFavoriteVideo"
                }
            }()
            
            
            let URL = NSURL(string: DSRouter.baseURLString)
            let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
            
            
            switch self {
            case .addUserFavoriteVideo(let UserFavorite):
                
                URLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let parameters = ["userId":UserFavorite.userId,"videoId":UserFavorite.videoId,"status":UserFavorite.status]
                do {
                
                    URLRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions())
                    
                    
                }catch{
                    
                }
                
            default: break
                
            }
            let encoding = Alamofire.ParameterEncoding.URL
            return encoding.encode(URLRequest, parameters: nil).0
        }
    }
    
}









