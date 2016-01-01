//
//  DOAlertController.swift
//  DS
//
//  Created by langyue on 15/12/25.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit


let DOAlertActionEnabledDidChangeNotification = "DOAlertActionEnabledDidChangeNotification"

enum DOAlertActionStyle : Int {
    case Default
    case Cancel
    case Destructive
}


enum DOAlertControllerStyle : Int {
    case ActionSheet
    case Alert
}


class DOAlertAction : NSObject, NSCopying {
    
    var title: String
    var style: DOAlertActionStyle
    var handler: ((DOAlertAction!) -> Void)!
    var enabled: Bool {
        didSet {
         
            if (oldValue != enabled){
                NSNotificationCenter.defaultCenter().postNotificationName(DOAlertActionEnabledDidChangeNotification, object: nil)
            }
            
        }
    }
    
    
    required init(title: String,style: DOAlertActionStyle,handler: ((DOAlertAction!)->Void)!) {
        
        self.title = title
        self.style = style
        self.handler = handler
        self.enabled = true
        
    }
    
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = self.dynamicType.init(title: title, style: style, handler: handler)
        copy.enabled = self.enabled
        return copy
    }
   
}



class DOAlertAnimation : NSObject,UIViewControllerAnimatedTransitioning {
    
    let isPresenting : Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        if isPresenting {
            return 0.45
        }else{
            return 0.25
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            self.presentAnimateTransition(transitionContext)
        }else{
            self.dismissAnimateTransition(transitionContext)
        }
    
    }
    
    
    func presentAnimateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DOAlertController
        let containerView = transitionContext.containerView()
        alertController.overlayView.alpha = 0.0
        
        
        
        
        
    }
    
    
    func dismissAnimateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        
        
    }
    
    
    
    
    
    
    
    
}






class DOAlertController: UIViewController,UITextFieldDelegate,UIViewControllerTransitioningDelegate {

    
    var message: String?
    private(set) var preferredStyle: DOAlertControllerStyle?
    
    private var overlayView = UIView()
    var overlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    
    private var containerView = UIView()
    private var containerViewBottomSpaceConstraint: NSLayoutConstraint!
    
    
    //AlertView
    private var alertView = UIView()
    var alertViewBgColor = UIColor(red: 239/255.0, green: 240/255.0, blue: 242/255.0, alpha: 1.0)
    private var alertViewWidth : CGFloat = 270.0
    private var alertViewHeightConstraint: NSLayoutConstraint!
    private var alertViewPadding : CGFloat = 15.0
    private var innerContentWidth : CGFloat = 240.0
    private let actionSheetBounceHeight: CGFloat = 20.0
    
    //TextAreaScrollView
    private var textAreaScrollView = UIScrollView()
    private var textAreaHeight : CGFloat = 0.0
    
    
    //TextAreaView
    private var textAreaView = UIView()
    
    //TextContainer
    private var textContainer = UIView()
    private var textContainerHeightConstraint : NSLayoutConstraint!
    //TitleLabel
    private var titleLabel = UILabel()
    var titleFont = UIFont(name: "HelveticaNeue-Bold", size: 18)
    var titleTextColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
    
    //MessageView
    private var messageView = UILabel()
    var messageFont = UIFont(name: "HelveticaNeue", size:15)
    var messageTextColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1.0)
    //TextFieldContainerView
    private var textFieldContainerView = UIView()
    var textFieldBorderColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1.0)
    
    //TextFields
    private(set) var textFields: [AnyObject]?
    private let textFieldHeight : CGFloat = 30.0
    var textFieldBgColor = UIColor.whiteColor()
    private let textFieldCornerRadius : CGFloat = 4.0
    
    //ButtonAreaScrollView
    private var buttonAreaScrollView = UIScrollView()
    private var buttonAreaScrollViewHeightConstraint :  NSLayoutConstraint!
    private var buttonAreaHeight: CGFloat = 0.0
    
    //ButtonAreaView
    private var buttonAreaView = UIView()
    //ButtonContainer
    private var buttonContainer = UIView()
    private var buttonContainerHeightConstraint: NSLayoutConstraint!
    private let buttonHeight : CGFloat = 44.0
    private var buttonMargin: CGFloat = 10.0
    
    
    
    //Actions
    private(set) var actions: [AnyObject] = []
    //Buttons
    private var buttons = [UIButton]()
    
    var buttonFont : [DOAlertActionStyle : UIFont!] =
    
        [
            .Default : UIFont(name: "HelveticaNeue-Bold", size: 16),
            .Cancel : UIFont(name: "HelveticaNeue-Bold", size: 16),
            .Destructive : UIFont(name: "HelvetocaNeue-Bold", size: 16)
        ]
    
    var buttonTextColor : [DOAlertActionStyle : UIColor] =
    
        [
            .Default : UIColor.whiteColor(),
            .Cancel : UIColor.whiteColor(),
            .Destructive : UIColor.whiteColor()
        ]
    
    
    var buttonBgColor : [DOAlertActionStyle : UIColor] =
    
        [
            .Default : UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1),
            .Cancel : UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 1),
            .Destructive : UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
    ]
    
    
    var buttonBgColorHighlighted : [DOAlertActionStyle : UIColor] = [
        .Default : UIColor(red: 74/255, green: 163/255, blue: 223/255, alpha: 1),
        .Cancel: UIColor(red: 140/255, green: 152/255, blue: 153/255, alpha: 1),
        .Destructive: UIColor(red: 234/255, green: 97/255, blue: 83/255, alpha: 1)
    ]
    
    
    private var buttonCornerRadius : CGFloat = 4.0
    private var layoutFlg = false
    private var keyboardHeight : CGFloat = 0.0
    private var cancelButtonTag = 0
    
    
    
    convenience init(title: String?,message: String?,preferredStyle:DOAlertControllerStyle){
        
        self.init(nibName:nil,bundle:nil)
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAlertActionEnabledDidChangeNotification:", name: DOAlertActionEnabledDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)


        //Delegate
        self.transitioningDelegate = self
        //Screen Size
        var screenSize = UIScreen.mainScreen().bounds.size
        if ((UIDevice.currentDevice().systemVersion as NSString).floatValue < 8.0){
            if(UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)){
                screenSize = CGSizeMake(screenSize.height, screenSize.width)
            }
        }
        
        
        if(!isAlert()){
            alertViewWidth = screenSize.width
            alertViewPadding = 8.0
            innerContentWidth = (screenSize.height > screenSize.width) ? screenSize.width - alertViewPadding * 2 : screenSize.height - alertViewPadding * 2
            buttonMargin = 8.0
            buttonCornerRadius  = 6.0
        }
        
        self.view.frame.size = screenSize
        self.view.addSubview(overlayView)
        self.view.addSubview(containerView)
        containerView.addSubview(alertView)
        alertView.addSubview(textAreaScrollView)
        textAreaScrollView.addSubview(textAreaView)
        textAreaView.addSubview(textContainer)
        alertView.addSubview(buttonAreaScrollView)
        
        buttonAreaScrollView.addSubview(buttonAreaView)
        buttonAreaView.addSubview(buttonContainer)
        
        
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        textAreaScrollView.translatesAutoresizingMaskIntoConstraints = false
        textAreaView.translatesAutoresizingMaskIntoConstraints = false
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonAreaScrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonAreaView.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        let overlayViewTopSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        
        let overlayViewRightSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0)
        
        let overlayViewLeftSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        
        let overlayBottomSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        
        
        
        let containerViewTopSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let containerViewRightSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let containerViewLeftSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        containerViewBottomSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([overlayViewTopSpaceConstraint, overlayViewRightSpaceConstraint, overlayViewLeftSpaceConstraint, overlayViewBottomSpaceConstraint, containerViewTopSpaceConstraint, containerViewRightSpaceConstraint, containerViewLeftSpaceConstraint, containerViewBottomSpaceConstraint])
        
        
        
        
        if (isAlert()) {
            // ContainerView
            let alertViewCenterXConstraint = NSLayoutConstraint(item: alertView, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
            let alertViewCenterYConstraint = NSLayoutConstraint(item: alertView, attribute: .CenterY, relatedBy: .Equal, toItem: containerView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
            containerView.addConstraints([alertViewCenterXConstraint, alertViewCenterYConstraint])
            
            // AlertView
            let alertViewWidthConstraint = NSLayoutConstraint(item: alertView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: alertViewWidth)
            alertViewHeightConstraint = NSLayoutConstraint(item: alertView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 1000.0)
            alertView.addConstraints([alertViewWidthConstraint, alertViewHeightConstraint])
            
        } else {
            // ContainerView
            let alertViewCenterXConstraint = NSLayoutConstraint(item: alertView, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
            let alertViewBottomSpaceConstraint = NSLayoutConstraint(item: alertView, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1.0, constant: actionSheetBounceHeight)
            let alertViewWidthConstraint = NSLayoutConstraint(item: alertView, attribute: .Width, relatedBy: .Equal, toItem: containerView, attribute: .Width, multiplier: 1.0, constant: 0.0)
            containerView.addConstraints([alertViewCenterXConstraint, alertViewBottomSpaceConstraint, alertViewWidthConstraint])
            
            // AlertView
            alertViewHeightConstraint = NSLayoutConstraint(item: alertView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 1000.0)
            alertView.addConstraint(alertViewHeightConstraint)
        }
        
        // AlertView
        let textAreaScrollViewTopSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .Top, relatedBy: .Equal, toItem: alertView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let textAreaScrollViewRightSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .Right, relatedBy: .Equal, toItem: alertView, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let textAreaScrollViewLeftSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .Left, relatedBy: .Equal, toItem: alertView, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let textAreaScrollViewBottomSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .Bottom, relatedBy: .Equal, toItem: buttonAreaScrollView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let buttonAreaScrollViewRightSpaceConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .Right, relatedBy: .Equal, toItem: alertView, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let buttonAreaScrollViewLeftSpaceConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .Left, relatedBy: .Equal, toItem: alertView, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let buttonAreaScrollViewBottomSpaceConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .Bottom, relatedBy: .Equal, toItem: alertView, attribute: .Bottom, multiplier: 1.0, constant: isAlert() ? 0.0 : -actionSheetBounceHeight)
        alertView.addConstraints([textAreaScrollViewTopSpaceConstraint, textAreaScrollViewRightSpaceConstraint, textAreaScrollViewLeftSpaceConstraint, textAreaScrollViewBottomSpaceConstraint, buttonAreaScrollViewRightSpaceConstraint, buttonAreaScrollViewLeftSpaceConstraint, buttonAreaScrollViewBottomSpaceConstraint])
        
        // TextAreaScrollView
        let textAreaViewTopSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .Top, relatedBy: .Equal, toItem: textAreaScrollView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let textAreaViewRightSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .Right, relatedBy: .Equal, toItem: textAreaScrollView, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let textAreaViewLeftSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .Left, relatedBy: .Equal, toItem: textAreaScrollView, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let textAreaViewBottomSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .Bottom, relatedBy: .Equal, toItem: textAreaScrollView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let textAreaViewWidthConstraint = NSLayoutConstraint(item: textAreaView, attribute: .Width, relatedBy: .Equal, toItem: textAreaScrollView, attribute: .Width, multiplier: 1.0, constant: 0.0)
        textAreaScrollView.addConstraints([textAreaViewTopSpaceConstraint, textAreaViewRightSpaceConstraint, textAreaViewLeftSpaceConstraint, textAreaViewBottomSpaceConstraint, textAreaViewWidthConstraint])
        
        // TextArea
        let textAreaViewHeightConstraint = NSLayoutConstraint(item: textAreaView, attribute: .Height, relatedBy: .Equal, toItem: textContainer, attribute: .Height, multiplier: 1.0, constant: 0.0)
        let textContainerTopSpaceConstraint = NSLayoutConstraint(item: textContainer, attribute: .Top, relatedBy: .Equal, toItem: textAreaView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let textContainerCenterXConstraint = NSLayoutConstraint(item: textContainer, attribute: .CenterX, relatedBy: .Equal, toItem: textAreaView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        textAreaView.addConstraints([textAreaViewHeightConstraint, textContainerTopSpaceConstraint, textContainerCenterXConstraint])
        
        // TextContainer
        let textContainerWidthConstraint = NSLayoutConstraint(item: textContainer, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: innerContentWidth)
        textContainerHeightConstraint = NSLayoutConstraint(item: textContainer, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 0.0)
        textContainer.addConstraints([textContainerWidthConstraint, textContainerHeightConstraint])
        
        // ButtonAreaScrollView
        buttonAreaScrollViewHeightConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 0.0)
        let buttonAreaViewTopSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .Top, relatedBy: .Equal, toItem: buttonAreaScrollView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let buttonAreaViewRightSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .Right, relatedBy: .Equal, toItem: buttonAreaScrollView, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let buttonAreaViewLeftSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .Left, relatedBy: .Equal, toItem: buttonAreaScrollView, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let buttonAreaViewBottomSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .Bottom, relatedBy: .Equal, toItem: buttonAreaScrollView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let buttonAreaViewWidthConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .Width, relatedBy: .Equal, toItem: buttonAreaScrollView, attribute: .Width, multiplier: 1.0, constant: 0.0)
        buttonAreaScrollView.addConstraints([buttonAreaScrollViewHeightConstraint, buttonAreaViewTopSpaceConstraint, buttonAreaViewRightSpaceConstraint, buttonAreaViewLeftSpaceConstraint, buttonAreaViewBottomSpaceConstraint, buttonAreaViewWidthConstraint])
        
        // ButtonArea
        let buttonAreaViewHeightConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .Height, relatedBy: .Equal, toItem: buttonContainer, attribute: .Height, multiplier: 1.0, constant: 0.0)
        let buttonContainerTopSpaceConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .Top, relatedBy: .Equal, toItem: buttonAreaView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let buttonContainerCenterXConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .CenterX, relatedBy: .Equal, toItem: buttonAreaView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        buttonAreaView.addConstraints([buttonAreaViewHeightConstraint, buttonContainerTopSpaceConstraint, buttonContainerCenterXConstraint])
        
        // ButtonContainer
        let buttonContainerWidthConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: innerContentWidth)
        buttonContainerHeightConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 0.0)
        buttonContainer.addConstraints([buttonContainerWidthConstraint, buttonContainerHeightConstraint])
        
        
        
        
    }
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        layoutView()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!isAlert() && cancelButtonTag != 0) {
            let tapGesture = UITapGestureRecognizer(target: self, action: "handleContainerViewTapGesture:")
            containerView.addGestureRecognizer(tapGesture)
        }
    }
    
    
    func layoutView(){
        
        if(layoutFlg){
            return
        }
        layoutFlg = true
        
        
        
        overlayView.backgroundColor = overlayColor
        alertView.backgroundColor = alertViewBgColor
        
        
        let hasTitle : Bool = title != nil && title != ""
        let hasMessage : Bool = message != nil && message != ""
        let hasTextField : Bool = textFields != nil && textFields?.count > 0
        
        var textAreaPositionY: CGFloat = alertViewPadding
        if(!isAlert()){
            textAreaPositionY += alertViewPadding
        }
        
        
        
        if (hasTitle){
            titleLabel.frame.size = CGSizeMake(innerContentWidth, 0.0)
            titleLabel.numberOfLines = 0;
            titleLabel.textAlignment = .Center
            titleLabel.font = titleFont
            titleLabel.textColor = titleTextColor
            titleLabel.text = title
            titleLabel.sizeToFit()
            titleLabel.frame = CGRectMake(0, textAreaPositionY, innerContentWidth, titleLabel.frame.height);
            textContainer.addSubview(titleLabel)
            textAreaPositionY += titleLabel.frame.height + 5.0
        }
        
        
        
        // MessageView
        if (hasMessage) {
            messageView.frame.size = CGSizeMake(innerContentWidth, 0.0)
            messageView.numberOfLines = 0
            messageView.textAlignment = .Center
            messageView.font = messageFont
            messageView.textColor = messageTextColor
            messageView.text = message
            messageView.sizeToFit()
            messageView.frame = CGRectMake(0, textAreaPositionY, innerContentWidth, messageView.frame.height)
            textContainer.addSubview(messageView)
            textAreaPositionY += messageView.frame.height + 5.0
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
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
