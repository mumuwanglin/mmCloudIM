//
//  mmLoginViewController.swift
//  mumuCloudIM
//
//  Created by 王林 on 16/2/16.
//  Copyright © 2016年 王林. All rights reserved.
//

import UIKit

//extension UIView{
//    @IBInspectable var cornerRadius: CGFloat{
//        get{
//            return layer.cornerRadius
//        }
//        
//        set{
//            layer.cornerRadius = newValue
//            layer.masksToBounds = (newValue > 0)
//        }
//    }
//}

class mmLoginViewController: UIViewController, RCAnimatedImagesViewDelegate{

    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var wallPaperView: RCAnimatedImagesView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wallPaperView.delegate = self
        self.wallPaperView.startAnimating()
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 1
    }
    
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "login_background.png")
    }
    
//    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
//        return 2
//    }
//    
//    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
//        return UIImage(named: "login_background.png")
//    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        UIView.animateWithDuration(1.0) { () -> Void in
                self.loginStackView.axis = UILayoutConstraintAxis.Vertical
        }
        
    }
    @IBAction func loginAction(sender: AnyObject) {
        let query = AVQuery(className: "mmUser")
        query.whereKey("user", equalTo: self.user.text)
        
        query.getFirstObjectInBackgroundWithBlock { (existObject, e) -> Void in
            if existObject != nil{

                self.performSegueWithIdentifier("toConversationList", sender: self)
            }else{
                self.successNotice("还要未注册")
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
