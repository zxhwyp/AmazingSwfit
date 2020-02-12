//
//  BaseViewController.swift
//  AmazingSwfit
//
//  Created by 周小华 on 2020/2/12.
//  Copyright © 2020 周小华. All rights reserved.
//

import UIKit
import URLNavigator

class BaseViewController: UIViewController {
    
    var navogator: NavigatorType {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.navigator
    }
    
    
}
