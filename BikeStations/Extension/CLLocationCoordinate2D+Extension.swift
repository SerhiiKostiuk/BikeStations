//
//  CLLocationCoordinate2D+Extension.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {

    func distance(to: CLLocationCoordinate2D) -> CLLocationDistance {
        MKMapPoint(self).distance(to: MKMapPoint(to))
    }

}
