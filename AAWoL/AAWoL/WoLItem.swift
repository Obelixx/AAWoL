//
//  WoLItem.swift
//  AAWoL
//
//  Created by AMD OS X on 06/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

import Foundation

@objc public class WoLItem: NSObject{
    
    public var macAdress:String;
    
    public var ipAdress:String;
    
    public var mask:String;
    
    public var port: Int = 7{
        didSet (newPort){
            if(newPort <= 1){
                port = 1;
            } else if(newPort >= 65535){
                port = 65535;
            }
        }
    }
    
    init(withMacAddress: String, withIpAddress: String, withMask: String, withPort: Int) {
        self.macAdress = withMacAddress;
        self.ipAdress = withIpAddress;
        self.mask = withMask;
        self.port = withPort;
    }
    
}