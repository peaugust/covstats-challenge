//
//  CoreViewController.swift
//  cov-stats
//
//  Created by Pedro Freddi on 5/5/21.
//  Copyright © 2018 Jungle Devs. All rights reserved.
//

import UIKit

class CoreViewController: UITabBarController {

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeViewModel = HomeViewModel(reportsRepository: AppDelegate.shared.reportsRepository)
        let homeViewController = HomeViewController.initModule(viewModel: homeViewModel)
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ic-home"), selectedImage: nil)
        let mapViewController = MapViewController.initModule()
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(named: "ic-map"), selectedImage: nil)
        
        viewControllers = [homeViewController, mapViewController]
        
        UITabBar.appearance().tintColor = UIColor.brandColor
    }
}
