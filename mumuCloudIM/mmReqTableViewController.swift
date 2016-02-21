//
//  mmReqTableViewController.swift
//  mumuCloudIM
//
//  Created by 王林 on 16/2/17.
//  Copyright © 2016年 王林. All rights reserved.
//

import UIKit

class mmReqTableViewController: UITableViewController {


    @IBOutlet weak var user: UITextBox!
    @IBOutlet weak var pass: UITextBox!
    @IBOutlet weak var email: UITextBox!

    @IBOutlet var textField: [UITextField]!
    
    @IBOutlet weak var region: UITextBox!
    @IBOutlet weak var question: UITextBox!
    @IBOutlet weak var answer: UITextBox!
    override func viewDidLoad() {
        super.viewDidLoad()

//        var (userOK , passOK , emailOK) = (false , false , false)
        let doneButton = self.navigationItem.rightBarButtonItem
        
        var possibleInputs:Inputs = []
        
        let v1 = AJWValidator(type: .String)
        v1.addValidationToEnsureMinimumLength(3, invalidMessage: "用户名至少3位")
        v1.addValidationToEnsureMaximumLength(15, invalidMessage: "用户名之多15位")
        self.user.ajw_attachValidator(v1)
        
        v1.validatorStateChangedHandler = {(newState:AJWValidatorState) -> Void in
            switch newState{
                case .ValidationStateValid:
                    self.user.highlightState = .Default
                    possibleInputs.unionInPlace(Inputs.user)
//                    userOK = true
                default:
                    let errorMsg = v1.errorMessages.first as? String
                    self.user.highlightState = UITextBoxHighlightState.Wrong(errorMsg!)
                    possibleInputs.subtractInPlace(Inputs.user)
//                    userOK = false
            }
//            doneButton?.enabled = userOK && passOK && emailOK
            doneButton?.enabled = possibleInputs.isAllOK()
//            doneButton?.enabled = possibleInputs.boolValue
        }
        
        let v2 = AJWValidator(type: .String)
        v2.addValidationToEnsureMinimumLength(3, invalidMessage: "密码至少3位")
        v2.addValidationToEnsureMaximumLength(15, invalidMessage: "密码之多15位")
        self.pass.ajw_attachValidator(v2)
        
        v2.validatorStateChangedHandler = {(newState:AJWValidatorState) -> Void in
            switch newState{
            case .ValidationStateValid:
                self.pass.highlightState = .Default
                possibleInputs.unionInPlace(Inputs.pass)
//                passOK = true
            default:
                let errorMsg = v2.errorMessages.first as? String
                self.pass.highlightState = UITextBoxHighlightState.Wrong(errorMsg!)
//                passOK = false
                possibleInputs.subtractInPlace(Inputs.pass)
            }
//            doneButton?.enabled = userOK && passOK && emailOK
            doneButton?.enabled = possibleInputs.isAllOK()
//            doneButton?.enabled = possibleInputs.boolValue
        }
        
        let v3 = AJWValidator(type: .String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("邮箱格式错误")

        self.email.ajw_attachValidator(v3)
        
        v3.validatorStateChangedHandler = {(newState:AJWValidatorState) -> Void in
            switch newState{
            case .ValidationStateValid:
                self.email.highlightState = .Default
//                emailOK = true
                possibleInputs.unionInPlace(Inputs.email)
            default:
                let errorMsg = v3.errorMessages.first as? String
                self.email.highlightState = UITextBoxHighlightState.Wrong(errorMsg!)
//                emailOK = false
                possibleInputs.subtractInPlace(Inputs.email)
            }
//            doneButton?.enabled = userOK && passOK && emailOK
            doneButton?.enabled = possibleInputs.isAllOK()
//            doneButton?.enabled = possibleInputs.boolValue
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        self.pleaseWait()
        //建立用户的AVObject
        let user = AVObject(className: "mmUser")
        
        //把输入的文本框，设置到对象中
        user["user"] = self.user.text
        user["pass"] = self.pass.text
        user["email"] = self.email.text
        user["region"] = self.region.text
        user["question"] = self.question.text
        user["answer"] = self.answer.text
        
        //查询是否已经存在此用户
        let query = AVQuery(className: "mmUser")
        query.whereKey("user", equalTo: self.user.text)
        //执行查询
        query.getFirstObjectInBackgroundWithBlock { (existObject, e) -> Void in
            self.clearAllNotice()
            
            if existObject != nil{
                self.errorNotice("用户已注册")
                self.user.becomeFirstResponder()
            }else{
                self.successNotice("还要未注册")
                print("用户还没有注册")
                user.saveInBackgroundWithBlock({ (success, e) -> Void in
                    if success{
                        self.successNotice("注册成功", autoClear: true)
                        self.navigationController?.popViewControllerAnimated(true)
                    }else{
                        self.errorNotice(e.localizedDescription, autoClear: true)
                    }
                })
            }
        }
//        for subView in self.textField {
//            
//            if ((subView.text?.isEmpty) != nil){
//                self.successNotice("文本框为空", autoClear: true)
//                print("文本框为空")
//            }
//            
//        }
//        
//        let regex = "[A-Z0-9a-z._%=-]+@[A-Z0-9a-z]+\\.[A-Za-z]{2,4}"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        guard predicate.evaluateWithObject(email.text) else{
//            self.errorNotice("邮箱格式错误", autoClear: true)
//            return
//        }
        
//////////////////////
        
//        self.view.runBlockOnAllSubviews { (subView) -> Void in
//            if let subView = subView as? UITextField {
//                if ((subView.text?.isEmpty) != nil){
//                    print("文本框为空")
//                }
//            }
//        }
//        
//        let alert = UIAlertController(title: "提示", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
//        let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default) { (_) -> Void in
//            print("action")
//        }
//        alert.addAction(action)
//        self.presentViewController(alert, animated: true) { () -> Void in
//            print("present")
//        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.rightBarButtonItem!.enabled = false
        self.navigationController?.navigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
