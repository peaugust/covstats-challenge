//
//  UIViewController.swift
//  cov-stats
//
//  Created by Antonio Duarte on 2/2/18.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func findTopmostViewController() -> UIViewController {
        if let parentViewController = parent {
            return parentViewController.findTopmostViewController()
        } else {
            return self
        }
    }

    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    func showOkAlert(title: String? = nil, description: String? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { _ in completion?() }))
        self.present(alert, animated: true, completion: nil)
    }
}
