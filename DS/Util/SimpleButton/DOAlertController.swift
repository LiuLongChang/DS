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
    
    
    //private var
    
    
    
    
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
