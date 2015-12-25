//
//  ExceptionsViewController.swift
//  DS
//
//  Created by langyue on 15/12/25.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit

class ExceptionsViewController: UIViewController {

    
    @IBOutlet weak var exceptionsWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSURLRequest(URL: NSURL(string: "https://api.doushi.me/mzsm.html?")!)
        exceptionsWebView.loadRequest(request)
        

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
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
