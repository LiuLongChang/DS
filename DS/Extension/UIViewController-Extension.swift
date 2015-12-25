//
//  UIViewController-Extension.swift
//  DS
//
//  Created by langyue on 15/12/25.
//  Copyright © 2015年 langyue. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController {
    
    func setNav(){
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#f5f5f7")
        if let barFont = UIFont(name: "Helvetica Neue", size: 17.0) {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(rgba: "#f0a22a"),NSFontAttributeName:barFont]
            
            
        }
        
        
    }
    
    
    
}