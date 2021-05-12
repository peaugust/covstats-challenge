//
//  LocationHelper.swift
//  cov-stats
//
//  Created by Ígor Yamamoto on 03/07/18.
//  Copyright © 2021 Jungle Devs. All rights reserved.
//

import Foundation
import CoreLocation

protocol CurrentPositionDelegate: class {
    func didUpdateCurrentPosition(position: CLLocationCoordinate2D)
    func didFailCurrentPosition(error: Error)
    func didChangeAuthorization(status: CLAuthorizationStatus)
}

extension CurrentPositionDelegate {
    func didFailCurrentPosition(error: Error) {}
    func didChangeAuthorization(status: CLAuthorizationStatus) {}
}

final class LocationHelper: NSObject, CLLocationManagerDelegate {

    // MARK: Static

    static let shared = LocationHelper()

    // MARK: Variables

    weak var delegate: CurrentPositionDelegate?
    let locationManager = CLLocationManager()

    // MARK: Life cycle

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.pausesLocationUpdatesAutomatically = false
    }

    // MARK: Public

    func startMonitoringLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func stopMonitoringLocation() {
        delegate = nil
        locationManager.stopUpdatingLocation()
    }

    // MARK: Location Manager Delegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            delegate?.didUpdateCurrentPosition(position: location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailCurrentPosition(error: error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didChangeAuthorization(status: status)
    }
}
