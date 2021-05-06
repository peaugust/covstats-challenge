//
//  MapViewController.swift
//  cov-stats
//
//  Created by Pedro Freddi on 05/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit

class MapViewController: BaseViewController, StoryboardLoadable {

    // MARK: - Factory

    static func initModule() -> MapViewController {
        let viewController = loadFromStoryboard()
        return viewController
    }

    // MARK: - IBOutlets

    // MARK: - Properties

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Private

}

