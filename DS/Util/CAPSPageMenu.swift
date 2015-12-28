//
//  CAPSPageMenu.swift
//  DS
//
//  Created by langyue on 15/12/28.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit



@objc public protocol CAPSPageMenuDelegate {
    
    optional func willMoveToPage(controller: UIViewController,index: Int)
    optional func didMoveToPage(controller: UIViewController,index: Int)
    
}


class MenuItemView: UIView {
    
    
    var titleLabel : UILabel?
    var menuItemSeparator : UIView?
    
    func setUpMenuItemView(menuItemWidth:CGFloat,menuScrollViewHeight:CGFloat,indicatorHeight:CGFloat,separatorPercentageHeight:CGFloat,separatorWidth:CGFloat,separatoWidth:CGFloat,separatorRoundEdges:Bool,menuItemSeparatorColor:UIColor){
        
        titleLabel = UILabel(frame: CGRectMake(0.0,0.0,menuItemWidth,menuScrollViewHeight - indicatorHeight))
        
        menuItemSeparator = UIView(frame: CGRectMake(menuItemWidth-(separatorWidth),floor(menuScrollViewHeight*((1.0-separatorPercentageHeight)/2)),separatorWidth,floor(menuScrollViewHeight * separatorPercentageHeight)))
        
        
    }
    
    
    
    
    
}




public class CAPSPageMenu: UIViewController,UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    
    let menuScrollView = UIScrollView()
    let controllerScrollView = UIScrollView()
    var menuItems : [MenuItemView] = []
    var menuItemWidths : [CGFloat] = []
    
    
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
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
