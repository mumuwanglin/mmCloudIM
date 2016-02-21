//
//  mmConversationListController.swift
//  mumuCloudIM
//
//  Created by 王林 on 16/2/14.
//  Copyright © 2016年 王林. All rights reserved.
//

import UIKit

class mmConversationListController: RCConversationListViewController {

    let conVC = mmConversationController()
    

    @IBAction func showMenu(sender: AnyObject) {
        var frame = sender.valueForKey("view")?.frame
        frame?.origin.y = (frame?.origin.y)! + 30
        
        KxMenu.showMenuInView(self.view, fromRect: frame!, menuItems: [
            KxMenuItem("客服",image:UIImage(named: "serve") ,target:self,action:"ClickMenu1"),
            KxMenuItem("好友",image:UIImage(named: "group") ,target:self,action:"ClickMenu2")
            ])
        
        
    }
    
    func ClickMenu1(){
        print("客服")
    }
    func ClickMenu2(){
        print("好友")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        appDelegate?.ConnectServe({ () -> Void in
            print("成功")
            self.setDisplayConversationTypes([

                RCConversationType.ConversationType_PRIVATE.rawValue,
                
                RCConversationType.ConversationType_DISCUSSION.rawValue,

                RCConversationType.ConversationType_GROUP.rawValue,

                RCConversationType.ConversationType_CHATROOM.rawValue,
 
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
 
                RCConversationType.ConversationType_SYSTEM.rawValue,
 
                RCConversationType.ConversationType_APPSERVICE.rawValue,

                RCConversationType.ConversationType_PUBLICSERVICE.rawValue,

                RCConversationType.ConversationType_PUSHSERVICE.rawValue
                ])
            
            self.refreshConversationTableViewIfNeeded()
        })
    }

    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        
        conVC.targetId = model.targetId
        conVC.userName = model.conversationTitle
        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        
        conVC.title = model.conversationTitle
        
        self.performSegueWithIdentifier("tapOnCell", sender: self)
//
//        self.navigationController?.pushViewController(conVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destVC = segue.destinationViewController as? mmConversationController
        
        destVC?.targetId = conVC.targetId;
        destVC?.userName = conVC.userName
        destVC?.conversationType = conVC.conversationType
        destVC?.title = conVC.title
        
        
        self.tabBarController?.tabBar.hidden = true
        
    }

}
