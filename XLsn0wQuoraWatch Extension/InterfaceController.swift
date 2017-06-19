//
//  InterfaceController.swift
//  XLsn0wQuoraWatch Extension
//
//  Created by XLsn0w on 2017/6/19.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
    
    
    var wcSession:WCSession?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        self.wcSession = WCSession.default()
        wcSession?.delegate = self as? WCSessionDelegate;
        wcSession?.activate()
        
        
        //        self.session = [WCSession defaultSession];
        //        self.session.delegate = self;
        //        //* 必须激活session */
        //        [self.session activateSession];
        
        // Configure interface objects here.
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
