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
        
        menuItemSeparator?.backgroundColor = menuItemSeparatorColor
        if separatorRoundEdges {
            menuItemSeparator?.layer.cornerRadius = (menuItemSeparator?.frame.width)! / 2
        }
        
        menuItemSeparator?.hidden = true
        self.addSubview(menuItemSeparator!)
        self.addSubview(titleLabel!)
        
    }
    
    
    func setTitleText(text: NSString){
        if titleLabel != nil {
            titleLabel?.text = text as String
            titleLabel?.numberOfLines = 0
            titleLabel?.sizeToFit()
        }
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
    case UnselectedMenuItemLabelColor(UIColor)
    case UseMenuLikeSegmentedControl(Bool)
    case MenuItemSeparatorRoundEdges(Bool)
    case MenuItemFont(UIFont)
    case MenuItemSeparatorPercentageHeight(CGFloat)
    case MenuItemWidth(CGFloat)
    case EnableHorizontalBounce(Bool)
    case AddBottomMenuHairline(Bool)
    case MenuItemWidthBasedOnTitleTextWidth(Bool)
    case ScrollAnimationDurationOnMenuItemTap(Int)
    case CenterMenuItems(Bool)
    case HideTopMenuBar(Bool)
    
}





public class CAPSPageMenu: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {

    
    let menuScrollView = UIScrollView()
    let controllerScrollView = UIScrollView()
    var controllerArray : [UIViewController] = []
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
    public var scrollMenuBackgroundColor : UIColor = UIColor.blackColor()
    
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
    
    public init(viewControllers: [UIViewController],frame: CGRect,options: [String : AnyObject]?){
        super.init(nibName: nil,bundle: nil)
        controllerArray = viewControllers
        self.view.frame = frame
    }
    
    
    public convenience init(viewControllers:[UIViewController],frame: CGRect,pageMenuOptions:[CAPSPageMenuOption]?){
        self.init(viewControllers:viewControllers,frame:frame,options:nil)
        if let options = pageMenuOptions {
            
            for option in options{
                
                switch (option){
                case let .SelectionIndicatorHeight(value):
                    selectionIndicatorHeight = value
                case let .MenuItemSeparatorWidth(value):
                    menuItemSeparatorWidth = value
                case let .ScrollMenuBackgroundColor(value):
                    scrollMenuBackgroundColor = value
                case let .ViewBackgroundColor(value):
                    viewBackgroundColor = value
                case let .BottomMenuHairlineColor(value):
                    bottomMenuHairlineColor = value
                case let .SelectionIndicatorColor(value):
                    selectionIndicatorColor = value
                case let .MenuItemSeparatorColor(value):
                    menuItemSeparatorColor = value
                case let .MenuMargin(value):
                    menuMargin = value
                case let .MenuHeight(value):
                    menuHeight = value
                case let .SelectedMenuItemLabelColor(value):
                    selectedMenuItemLabelColor = value
                case let .UnselectedMenuItemLabelColor(value):
                    unselectedMenuItemLabelColor = value
                case let .UseMenuLikeSegmentedControl(value):
                    useMenuLikeSegmentedControl = value
                case let .MenuItemSeparatorRoundEdges(value):
                    menuItemSeparatorRoundEdges = value
                case let .MenuItemFont(value):
                    menuItemFont = value
                case let .MenuItemSeparatorPercentageHeight(value):
                    menuItemSeparatorPercentageHeight = value
                case let .MenuItemWidth(value):
                    menuItemWidth = value
                case let .EnableHorizontalBounce(value):
                    enableHorizontalBounce = value
                case let .AddBottomMenuHairline(value):
                    addBottomMenuHairline = value
                case let .MenuItemWidthBasedOnTitleTextWidth(value):
                    menuItemWidthBasedOnTitleTextWidth = value
                case let .ScrollAnimationDurationOnMenuItemTap(value):
                    scrollAnimationDurationOnMenuItemTap = value
                case let .CenterMenuItems(value):
                    centerMenuItems = value
                case let .HideTopMenuBar(value):
                    hideTopMenuBar = value
                }
                
            }
            
        }
    }
    
    

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        return true
    }
    
    public override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
    
    func setUpUserInterface(){
        let viewsDictionary = ["menuScrollView":menuScrollView,"controllerScrollView":controllerScrollView]
        
        controllerScrollView.pagingEnabled = true
        controllerScrollView.translatesAutoresizingMaskIntoConstraints = false
        controllerScrollView.alwaysBounceHorizontal = enableHorizontalBounce
        controllerScrollView.bounces = enableHorizontalBounce
        controllerScrollView.frame = CGRectMake(0.0, menuHeight, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(controllerScrollView)
        
        
        let controllerScrollView_constraint_H : Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[controllerScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let controllerScrollView_constraint_V : Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[controllerScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(controllerScrollView_constraint_H)
        self.view.addConstraints(controllerScrollView_constraint_V)
        
        //Set up menu scroll view
        menuScrollView.translatesAutoresizingMaskIntoConstraints  = false
        menuScrollView.frame = CGRectMake(0.0, 0.0, self.view.frame.width, menuHeight)
        self.view.addSubview(menuScrollView)
        
        
        
        
        let menuScrollView_constraint_H : Array = NSLayoutConstraint
        
        
        
        
    }
    
    
    
    
    
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
