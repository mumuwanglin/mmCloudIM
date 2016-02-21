//
//  AppDelegate.swift
//  mumuCloudIM
//
//  Created by 王林 on 16/1/27.
//  Copyright © 2016年 王林. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RCIMUserInfoDataSource {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        

        RCIM.sharedRCIM().userInfoDataSource = self
        AVOSCloud.setApplicationId("kzBnKXfP4KP5gHKzkwLwAbwG-gzGzoHsz", clientKey: "Wb76eWQsQMdkCvVQ4pMO1o8y")
        return true
    }
    
    func ConnectServe(completion:()->Void){
        //查询保存的token
        let token = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken") as? String
        
        //初始化appkey
        RCIM.sharedRCIM().initWithAppKey("z3v5yqkbvsb30")
        
        
        
        //用token测试连接
        RCIM.sharedRCIM().connectWithToken("LTnCMx8vW4grUxmqEIqUOu2MZ7afkry8TyWkJWfKh4TUUHDd2nv+CjY8XCCHd03wVtxOrnwld6EN5iBims6FOw==", success: { (_) -> Void in
            print("success")
            
            let currentUser = RCUserInfo(userId: "10000", name: "mumu", portrait: "http://ww4.sinaimg.cn/large/005Iw5MDgw1f0f86q7r6yj30rs0ij0u4.jpg")
            
            RCIMClient.sharedRCIMClient().currentUserInfo = currentUser
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion()
            })
            
            
            }, error: { (_) -> Void in
                print("error")
            }) { () -> Void in
                print("token error")
        }
    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        switch userId{
            case "10000":
                userInfo.name = "mumu"
                userInfo.portraitUri = "http://ww4.sinaimg.cn/large/005Iw5MDgw1f0f86q7r6yj30rs0ij0u4.jpg"
            case "10001":
                userInfo.name = "Lin"
                userInfo.portraitUri = "http://ww4.sinaimg.cn/large/005Iw5MDgw1f0f86q7r6yj30rs0ij0u4.jpg"
            default:
                print("查无此用户")
        }
        return completion(userInfo)
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


}

