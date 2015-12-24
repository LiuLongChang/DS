//
//  AppDelegate.swift
//  DS
//
//  Created by langyue on 15/12/22.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData
import Alamofire






@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if userDefaults.objectForKey("userInfo") != nil{
            
            let userDictionary = userDefaults.objectForKey("userInfo") as! NSDictionary
            
            let userInfo = User(id: userDictionary["id"] as! Int, nickName: userDictionary["nickName"] as! String, password: "", headImage: userDictionary["headImage"] as! String, phone: userDictionary["phone"] as! String, gender: userDictionary["gender"] as! Int, platformId: userDictionary["platformId"] as! String, platformName: userDictionary["platformName"] as! String)
            
            DataCenter.shareDataCenter.user = userInfo
            
        }
        
        
        
        NSThread.sleepForTimeInterval(1.0)
        UITabBar.appearance().tintColor = UIColor(rgba: "#f0a22a")
        
        IQKeyboardManager.sharedManager().enable = true
        
        
        UMSocialData.setAppKey("563b6bdc67e58e73ee002acd")
        UMSocialQQHandler.setQQWithAppId("1104864621", appKey: "AQKpnMRxELiDWHwt", url: "www.itjh.net")
        UMSocialQQHandler.setSupportWebView(true)
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
        UMSocialWechatHandler.setWXAppId("wxfd23fac852a54c97", appSecret: "d4624c36b6795d1d99dcf0547af5443d", url: "www.doushi.me")
        
        
        SMSSDK.registerApp("c06e0d3b9ec2", withSecret: "ad02d765bad19681273e61a5c570a145")
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        
        APService.registerForRemoteNotificationTypes(UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue, categories: nil)
        
            APService.setupWithOption(launchOptions)
            APService.setLogOFF()
        
        
        
        return true
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        //let handledShortCutItem - handle
        
    }
    
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem)->Bool{
        
        var handled = false
        let tabBar = UIApplication.sharedApplication().keyWindow?.rootViewController as! UITabBarController
        
        
        let nav = tabBar.selectedViewController as! UINavigationController
        
        if shortcutItem.type == "1" {
            let storyMy = UIStoryboard(name: "My", bundle: nil)
            
            let myCollectView = storyMy.instantiateViewControllerWithIdentifier("MyCollect") as!
            MyUserFavoriteTabVC
            myCollectView.title = "我的收藏"
            //
            nav.pushViewController(myCollectView, animated: true)
            
            handled = true
        }
        
        
        
        if shortcutItem.type == "2" {
            
            let storyMy = UIStoryboard(name: "Find", bundle: nil)
            let videoTaxisView = storyMy.instantiateViewControllerWithIdentifier("VideoTaxisTableViewController") as! VideoTaxisTabVC
            videoTaxisView.title = "排行榜"
            
            nav.pushViewController(videoTaxisView, animated: true)
            handled = true
            
        }
        
        return handled
        
    }
    
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        
        let tabBar = UIApplication.sharedApplication().keyWindow?.rootViewController as! UITabBarController
        UIApplication.sharedApplication().applicationIconBadgeNumber += 1
        
        
        let nav = tabBar.selectedViewController as! UINavigationController
        
        
        APService.handleRemoteNotification(userInfo)
        
        let applicationState = UIApplication.sharedApplication().applicationState.rawValue
        let userInfoDict = userInfo as NSDictionary
        let aps = userInfoDict["aps"] as! NSDictionary
        
        
        if applicationState == 0 {
            
            print("程序正在前台运行")
            let alertController = UIAlertController(title: aps["alert"] as? String, message: "搞笑视频来了！是否查看", preferredStyle: .Alert)
            
            
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelAction)
            
            
            let OKAction = UIAlertAction(title: "确定", style: .Default, handler: { (action) -> Void in
              self.goPlayVideo(userInfoDict)
            })
            alertController.addAction(cancelAction)
            
            
            
            nav.presentViewController(alertController, animated: true, completion: { () -> Void in
                
            })
            
        }else{
            self.goPlayVideo(userInfoDict)
        }
        
        
        
    }
    
    
    
    func goPlayVideo(userInfoDict:NSDictionary){
        
        let tabBar = UIApplication.sharedApplication().keyWindow?.rootViewController as! UITabBarController
        let nav = tabBar.selectedViewController as! UINavigationController
        //
        let aStoryboard = UIStoryboard(name: "Home", bundle: NSBundle.mainBundle())
        let playVideoViewController = aStoryboard.instantiateViewControllerWithIdentifier("playVideoView") as! PlayVideoViewController
        let videoId = userInfoDict["videoId"] as! String
        var userId = 0
        if user != nil{
            userId = user?.objectForKey("id") as! Int
        }
        
        HttpController.getVideoById(HttpClientByVideo.DSRouter.getVideosById(videoId, userId)) { (videoInfo) -> Void in
            DataCenter.shareDataCenter.videoInfo = videoInfo!
            nav.pushViewController(playVideoViewController, animated: true)
        }
        
        
    }
    
    
    
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    lazy var applicationDocumentsDirectory: NSURL = {
       let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
       
        let modelURL = NSBundle.mainBundle().URLForResource("ds_ios", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        
    }()
    
    
    
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do{
            
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,configuration: nil,URL:url,options:nil)
            
            
        }catch{
            
            
            var dict = [String:AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError),  \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    

    
    
    
    


}

