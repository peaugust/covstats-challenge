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

    static func initModule(viewModel: MapViewModel) -> MapViewController {
        let viewController = loadFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - IBOutlets

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var dropdownView: UIView!
    @IBOutlet private var dropdownLabel: UILabel!
    @IBOutlet private var dropdownIcon: UIImageView!
    @IBOutlet private var dropdownItems: DropdownItems!
    @IBOutlet private var spotedCasesAroundLabel: UILabel!

    // MARK: - Properties

    var currentPosition: CLLocationCoordinate2D? {
        didSet {
            guard currentPosition != nil else { return }
        }
    }
    var viewModel: MapViewModel?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObservables()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationHelper.shared.delegate = self
        LocationHelper.shared.startMonitoringLocation()
        parent?.title = "Discovery"
        dropdownItems.isHidden = true
    }

    // MARK: - Private

    private func setupObservables() {
        viewModel?.casesAroundSubject.subscribe(onNext: { [weak self] cases in
            if cases > 0 {
                self?.spotedCasesAroundLabel.text = "\(cases) spoted around you"
            } else {
                self?.spotedCasesAroundLabel.text = "There's no case around you"
            }
        }, onError: { [weak self] error in
            self?.showOkAlert(title: "Error", description: error.localizedDescription, completion: nil)
            self?.spotedCasesAroundLabel.text = "N/A"
        }).disposed(by: disposeBag)
        
        viewModel?.selectedFilterSubject.subscribe(onNext: { [weak self] currentFilter in
            self?.dropdownLabel.text = currentFilter
            self?.toggleDropdown()
        }).disposed(by: disposeBag)
    }

    private func setupView() {
        dropdownView.layer.cornerRadius = 5
        dropdownView.layer.borderColor = UIColor.gray60.withAlphaComponent(0.6).cgColor
        dropdownView.layer.borderWidth = 1
        let tapGesture = UITapGestureRecognizer()
        dropdownView.addGestureRecognizer(tapGesture)

        tapGesture.rx.event.bind(onNext: {[weak self] _ in
            self?.toggleDropdown()
        }).disposed(by: disposeBag) 
        
        dropdownLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        dropdownLabel.textColor = .black
        dropdownIcon.image = UIImage(named: "ic-arrow-down")
        
        dropdownItems.onSelectItem = viewModel?.setFilter(filter:)
        spotedCasesAroundLabel.textColor = .brandColor
        spotedCasesAroundLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        spotedCasesAroundLabel.textAlignment = .center
    }
    
    private func toggleDropdown() {
        dropdownIcon.transform = self.dropdownIcon.transform.rotated(by: .pi)
        UIView.animate(withDuration: 0.36, animations: {
            self.dropdownItems.isHidden = !self.dropdownItems.isHidden
            self.view.layoutIfNeeded()
        })
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
