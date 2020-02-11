//
//  Common.swift
//  AmazingSwfit
//
//  Created by 周小华 on 2020/2/11.
//  Copyright © 2020 周小华. All rights reserved.
//

import Foundation
import UIKit

///屏幕宽
let WindowW = UIScreen.main.bounds.width

///屏幕高
let WindowH = UIScreen.main.bounds.height


/// 自定义打印函数
func logger(message: Any, file: String = #file, _ line: Int = #line) {
    #if DEBUG
    let filename =  (file as NSString).lastPathComponent
    
    print("\(filename)-[第\(line)行]: \(message)")
    
    #endif
}
