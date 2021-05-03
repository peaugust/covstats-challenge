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
        if SessionHelper.shared.isUserLogged {
            presentCoreScreen()
        } else {
            presentLandingScreen()
        }
    }

    // MARK: Private

    private func presentLandingScreen() {
        let landingViewController = LandingViewController.initModule()
        presentAsRoot(landingViewController)
    }

    private func presentCoreScreen() {
        let coreViewController = CoreViewController.initModule()
        presentAsRoot(coreViewController)
    }
}

private extension RootRouter {
    func presentAsRoot(_ viewController: UIViewController) {
        guard let window = appDelegate.window else { return }
        window.backgroundColor = .white
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
    }
}
