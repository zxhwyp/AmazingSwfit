//
//  VCLogin.swift
//  AmazingSwfit
//
//  Created by 周小华 on 2020/2/11.
//  Copyright © 2020 周小华. All rights reserved.
//

import UIKit
import URLNavigator

prefix operator <--

class VcLogin: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        zlogger(message: "zzzz")
        
        <--self
    }
    
    static prefix func <--(vc: VcLogin) {
        zlogger(message: "fdd")
    }
    
}


struct People {
    
    static prefix func + (p1: People) {
        
    }
}
