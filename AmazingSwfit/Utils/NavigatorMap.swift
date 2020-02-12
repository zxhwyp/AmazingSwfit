//
//  NavigatorMap.swift
//  AmazingSwfit
//
//  Created by 周小华 on 2020/2/12.
//  Copyright © 2020 周小华. All rights reserved.
//

import Foundation
import URLNavigator
import SafariServices


enum NavigationMap {
  static func initialize(navigator: NavigatorType) {
    navigator.register("navigator://user/<username>") { url, values, context in
        return VcLogin()
    }
    navigator.register("http://<path:_>", self.webViewControllerFactory)
    navigator.register("https://<path:_>", self.webViewControllerFactory)

    navigator.handle("navigator://alert", self.alert(navigator: navigator))
    navigator.handle("navigator://<path:_>") { (url, values, context) -> Bool in
      // No navigator match, do analytics or fallback function here
      print("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
      return true
    }
  }

  private static func webViewControllerFactory(
    url: URLConvertible,
    values: [String: Any],
    context: Any?
  ) -> UIViewController? {
    guard let url = url.urlValue else { return nil }
    return SFSafariViewController(url: url)
  }

  private static func alert(navigator: NavigatorType) -> URLOpenHandlerFactory {
    return { url, values, context in
      guard let title = url.queryParameters["title"] else { return false }
      let message = url.queryParameters["message"]
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      navigator.present(alertController)
      return true
    }
  }
}
