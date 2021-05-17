//
//  MapViewController.swift
//  cov-stats
//
//  Created by Pedro Freddi on 05/05/21.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RxCocoa

class MapViewController: BaseViewController, StoryboardLoadable {

    // MARK: - Factory

    static func initModule() -> MapViewController {
        let viewController = loadFromStoryboard()
        return viewController
    }

    // MARK: - IBOutlets

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var dropdownView: UIView!
    @IBOutlet private var dropdownLabel: UILabel!
    @IBOutlet private var dropdownIcon: UIImageView!
    @IBOutlet private var dropdownItems: DropdownItems!
    
    // MARK: - Properties

    var currentPosition: CLLocationCoordinate2D? {
        didSet {
            guard currentPosition != nil else { return }
        }
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        dropdownItems.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationHelper.shared.delegate = self
        LocationHelper.shared.startMonitoringLocation()
        parent?.title = "Discovery"
    }

    // MARK: - Private
    
    private func setupView() {
        dropdownView.layer.cornerRadius = 5
        dropdownView.layer.borderColor = UIColor.gray60.withAlphaComponent(0.6).cgColor
        dropdownView.layer.borderWidth = 1
        let tapGesture = UITapGestureRecognizer()
        dropdownView.addGestureRecognizer(tapGesture)

        tapGesture.rx.event.bind(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.dropdownIcon.transform = self.dropdownIcon.transform.rotated(by: .pi)
            UIView.animate(withDuration: 0.36, animations: {
                self.dropdownItems.isHidden = !self.dropdownItems.isHidden
                self.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag) 

        dropdownLabel.text = "Discover Corona Virus by"
        dropdownLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        dropdownLabel.textColor = .black

        dropdownIcon.image = UIImage(named: "ic-arrow-down")
    }

}

// MARK: Current Position Delegate

extension MapViewController: CurrentPositionDelegate {

    func didUpdateCurrentPosition(position: CLLocationCoordinate2D) {
        guard let currentPosition = self.currentPosition else {
            self.currentPosition = position
            return
        }
        let currentLatitude = Double(currentPosition.latitude).rounded(toPlaces: 4)
        let currentLongitude = Double(currentPosition.longitude).rounded(toPlaces: 4)
        let newLatitude = Double(position.latitude).rounded(toPlaces: 4)
        let newLongitude = Double(position.longitude).rounded(toPlaces: 4)

        if currentLatitude != newLatitude || currentLongitude != newLongitude {
            self.currentPosition = position
        }
    }
}
