//
//  MyUserFavoriteTableVC.swift
//  DS
//
//  Created by langyue on 15/12/25.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit




class MyUserFavoriteTableVC: UITableViewController {
    
    var videos = NSMutableOrderedSet()
    
    var populatingVideo = false
    
    
    var currentPage = 0
    
    
    @IBOutlet var topView: UIView!
    
    
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    var type = 0
    
    var alertController: UIAlertController?
    
    var userId = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = UIColor(rgba: "#f0a22a")
        setNav()
        
        let user = userDefaults.objectForKey("userInfo")
        let aStoryboard = UIStoryboard(name: "My", bundle:NSBundle.mainBundle())
        
        if (user == nil){
            
            let title = "您还没有登录"
            let message = "收藏功能需要用户登录 进行云同步."
            let otherButtonTitle = "去登录"
            //let alertController =
            
            
            
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

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
