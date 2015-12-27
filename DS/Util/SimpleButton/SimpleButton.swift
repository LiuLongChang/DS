//
//  SimpleButton.swift
//  DS
//
//  Created by 刘隆昌 on 15/12/27.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit

@IBDesignable

public class SimpleButton: UIButton {
    

    typealias ControlState = UInt
    public var animationDuration: NSTimeInterval = 0.1
    public var animateStateChange: Bool = true
    
    
    lazy private var backgroundColors = [ControlState: CGColor]()
    lazy private var borderColors = [ControlState: CGColor]()
    lazy private var buttonScales = [ControlState: CGFloat]()
    lazy private var borderWidths = [ControlState: CGFloat]()
    lazy private var cornerRadius = [ControlState: CGFloat]()
    
    
    lazy private var shadowColors = [ControlState: CGColor]()
    lazy private var shadowOpacity = [ControlState: Float]()
    lazy private var shadowOffset = [ControlState: CGSize]()
    lazy private var shadowRadii = [ControlState: CGFloat]()
    
    
    
    
    override public var enabled: Bool{
        didSet{
            updateForStateChange(animateStateChange)
        }
    }
    
    override public var highlighted: Bool{
        didSet{
            updateForStateChange(animateStateChange)
        }
        
    }
    
    
    
    override public var selected: Bool {
        
        didSet{
            updateForStateChange(animateStateChange)
        }
        
    }
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            setCornerRadius(cornerRadius)
            
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            setBorderWidth(borderWidth)
        }
    }
    
    
    
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            if borderColor != nil{
                setBorderColor(borderColor!)
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
