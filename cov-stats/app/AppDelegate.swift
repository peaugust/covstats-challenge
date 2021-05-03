//
//  AppDelegate.swift
//  cov-stats
//
//  Created by Antonio Duarte on 2/2/18.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import UIKit

var appDelegate: AppDelegate {
    // swiftlint:disable:next force_cast
    return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    var window: UIWindow?

    // swiftlint:disable:next force_cast
    static let shared = UIApplication.shared.delegate as! AppDelegate

    // MARK: Life cycle

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLogger()
        presentInitialScreen()
        
        return true
    }

    // MARK: Actions

    func presentInitialScreen() {
        let rootRouter = RootRouter.initModule()
        rootRouter.presentInitialScreen()
    }

    // MARK: - Setup

    private func setupLogger() {
        APILogger.shared.level = .off
        APILogger.shared.startLogging()
    }
}
