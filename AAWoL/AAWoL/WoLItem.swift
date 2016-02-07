//
//  WoLItem.swift
//  AAWoL
//
//  Created by AMD OS X on 06/02/2016.
//  Copyright © 2016 AA. All rights reserved.
//

import Foundation

@objc public class WoLItem: NSObject{
    
    public var macAddress:String;
    
    public var ipAddress:String;
    
    public var mask:String;
    
    public var port: Int = 7{
        didSet (newPort){
            if(newPort <= 0){
                port = 0;
            } else if(newPort >= 65535){
                port = 65535;
            }
        }
    }
    
    init(withMacAddress: String, andIpAddress: String, andMask: String, andPort: Int) {
        self.macAddress = withMacAddress;
        self.ipAddress = andIpAddress;
        self.mask = andMask;
        self.port = andPort;
    }
    
}