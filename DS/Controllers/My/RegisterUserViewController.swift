//
//  RegisterUserViewController.swift
//  DS
//
//  Created by 刘隆昌 on 15/12/27.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MobileCoreServices
import Qiniu
import Validator



class RegisterUserViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIPopoverPresentationControllerDelegate {

    
    @IBOutlet weak var resultUILabel: UILabel!
    @IBOutlet weak var pwdResultUILabel: UILabel!
    @IBOutlet weak var codeUILabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var headImageView: UIImageView!
    //@IBOutlet weak var registerUserButton : corner
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
