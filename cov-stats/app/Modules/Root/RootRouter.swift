//
//  RootRouter.swift
//  cov-stats
//
//  Created by Antonio Duarte on 2/2/18.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import UIKit

final class RootRouter {

    // MARK: Static

    static func initModule() -> RootRouter {
        return RootRouter()
    }

    // MARK: Actions

    func presentInitialScreen() {
        let coreViewController = CoreViewController()
        presentAsRoot(coreViewController)
    }
}

private extension RootRouter {
    func presentAsRoot(_ viewController: UIViewController) {
        guard let window = appDelegate.window else { return }
        let navController = UINavigationController(rootViewController: viewController)
        window.backgroundColor = .white
        window.rootViewController = navController
        window.makeKeyAndVisible()

        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
    }
}
