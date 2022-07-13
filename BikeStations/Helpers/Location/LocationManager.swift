//
//  LocationManager.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {

    //MARK: - @Published Properties

    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?

    //MARK: - Public Properties

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    //MARK: - Private Properties

    private let locationManager = CLLocationManager()

    //MARK: - Initializer

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
    }
}
