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




public enum CAPSPageMenuOption {
    
    case SelectionIndicatorHeight(CGFloat)
    case MenuItemSeparatorWidth(CGFloat)
    case ScrollMenuBackgroundColor(UIColor)
    case ViewBackgroundColor(UIColor)
    case BottomMenuHairlineColor(UIColor)
    case SelectionIndicatorColor(UIColor)
    case MenuItemSeparatorColor(UIColor)
    case MenuMargin(CGFloat)
    case MenuHeight(CGFloat)
    case SelectedMenuItemLabelColor(UIColor)
    case UnselectedMenu
    
    
    
}





public class CAPSPageMenu: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    
    let menuScrollView = UIScrollView()
    let controllerScrollView = UIScrollView()
    var menuItems : [MenuItemView] = []
    var menuItemWidths : [CGFloat] = []
    
    
    
    public var menuHeight : CGFloat = 34.0
    public var menuMargin : CGFloat = 15.0
    public var menuItemWidth : CGFloat = 111.0
    public var selectionIndicatorHeight : CGFloat = 3.0
    var totalMenuItemWidthIfDefferentWidth : CGFloat = 0.0
    public var scrollAnimationDurationOnMenuItemTap : Int = 500
    var startingMenuMargin : CGFloat = 0.0
    var selectionIndicatorView : UIView = UIView()
    var currentPageIndex : Int = 0
    var lastPageIndex : Int = 0
    
    
    
    public var selectionIndicatorColor : UIColor = UIColor.whiteColor()
    public var selectedMenuItemLabelColor : UIColor = UIColor.whiteColor()
    public var unselectedMenuItemLabelColor : UIColor = UIColor.blackColor()
    public var viewBackgroundColor : UIColor = UIColor.whiteColor()
    public var bottomMenuHairlineColor : UIColor = UIColor.whiteColor()
    public var menuItemSeparatorColor : UIColor = UIColor.lightGrayColor()
    public var menuItemFont: UIFont = UIFont.systemFontOfSize(15.0)
    public var menuItemSeparatorPercentageHeight : CGFloat = 0.2
    public var menuItemSeparatorWidth : CGFloat = 0.5
    public var menuItemSeparatorRoundEdges : Bool = false
    public var addBottomMenuHairline : Bool = true
    
    
    
    public var menuItemWidthBasedOnTitleTextWidth : Bool = false
    public var useMenuLikeSegmentedControl : Bool = false
    public var centerMenuItems : Bool = false
    public var enableHorizontalBounce : Bool = false
    public var hideTopMenuBar : Bool = false
    
    
    
    
    
    
    var currentOrigentationIsPortrait : Bool = true
    var pageIndexForOrigentationChange : Int = 0
    var didLayoutSubviewsAfterRotation : Bool = false
    var didScrollAlready : Bool = false
    
    
    var lastControllerScrollViewContentOffset : CGFloat = 0.0
    var lastScrollDirection : CAPSPageMenuScrollDirection = .Other
    var startingPageForScroll : Int = 0
    var didTapMenuItemToScroll : Bool = false
    
    
    var pagesAddedDirtionary : [Int : Int] = [:]
    
    public weak var delegate : CAPSPageMenuDelegate?
    
    var tapTimer : NSTimer?
    
    enum CAPSPageMenuScrollDirection: Int {
        case Left
        case Right
        case Other
    }
    
    
//    
//    public init(ViewController: [UIViewController],frame: CGRect,options: [String : AnyObject]?){
//        super.init(nibName: nil,bundle: nil)
//        controllerScrollView
//        
//        
//    }
//    
    
    
    
    
    
    
    
    
    
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
