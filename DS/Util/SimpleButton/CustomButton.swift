//
//  CustomButton.swift
//  DS
//
//  Created by 刘隆昌 on 15/12/27.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit


@IBDesignable
class ScaleButton: SimpleButton {
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBackgroundColor(UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0),forState: .Normal)
        setTitle(".Normal", forState: .Normal)
        setTitle(".Highlighted", forState: .Highlighted)
        setScale(0.97,forState: .Highlighted)
    }
}


@IBDesignable
class BackgroundColorButton: SimpleButton {
    override func configureButtonStyles() {
        super.configureButtonStyles()
        
        setScale(0.98,forState: .Highlighted,animated: true)
        setShadowRadius(5,forState: .Normal, animated: true)
        setShadowRadius(10,forState: .Highlighted,animated: true)
        setShadowOpacity(0.6,forState: .Normal)
        setShadowOpacity(0.6,forState: .Highlighted)
        setShadowOffset(CGSize(width: 0, height: 1),forState: .Normal)
        setShadowOffset(CGSize(width: 0, height: 2),forState: .Highlighted)
        
        setBackgroundColor(UIColor(rgba: "#f0a22a"))
        setTitle("获取验证码", forState: .Normal)
        
        
    }
    
    
    
}


@IBDesignable
class BorderWidthButton: SimpleButton{
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setTitleColor(UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0), forState: .Normal)
        setBorderColor(UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0) ,forState: .Normal)
        setTitle(".Normal", forState: .Normal)
        setTitle(".Highlighted", forState: .Highlighted)
        setBorderWidth(2.0,forState: .Normal)
        setBorderWidth(8.0,forState: .Highlighted)
    }
}


@IBDesignable
class BorderColorButton: SimpleButton {
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setTitleColor(UIColor.grayColor(), forState: .Normal)
        setBorderWidth(4.0,forState: .Normal)
        setBorderColor(UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),forState: .Highlighted)
        setBorderColor(UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1.0),forState: .Highlighted)
        setTitle(".Normal", forState: .Normal)
        setTitle(".Highlighted", forState: .Highlighted)
    }
}



@IBDesignable
class CornerRadiusButton: SimpleButton {
    
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBackgroundColor(UIColor(rgba: "#f0a22a"),forState: .Normal)
        setTitle("登录", forState: .Normal)
        setCornerRadius(10.0,forState: .Normal)
    }
    
}



@IBDesignable
class CornerRadiusButtonByRes:SimpleButton{
    
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBackgroundColor(UIColor(rgba: "#f0a22a"),forState: .Normal)
        setTitle("注册", forState: .Normal)
        setCornerRadius(10.0,forState: .Normal)
        
        
    }
    
    
}


@IBDesignable
class CornerRadiusButtonByCode : SimpleButton {
    
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBackgroundColor(UIColor(rgba: "#f0a22a"),forState: .Normal)
        setTitle("获取验证码", forState: .Normal)
        setCornerRadius(10.0,forState: .Normal)
        setCornerRadius(10.0,forState: .Normal)
        
    }
    
}



@IBDesignable
class CornerRadiusButtonByHeadImage: SimpleButton {
    
    override func configureButtonStyles() {
        super.configureButtonStyles()
        setBackgroundColor(UIColor(rgba: "#f0a22a"),forState: .Normal)
        setCornerRadius(10.0,forState: .Normal)
    }
    
}



class CustomButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    
    
    
    
    
    
    
    
    

}
