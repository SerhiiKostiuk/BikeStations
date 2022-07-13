//
//  CardViewModel.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Combine
import CoreLocation

class CardViewModel: ObservableObject {

    //MARK: - @Published Properties

    @Published var distance: Int?

    //MARK: - Private Properties

    private let locationManager = LocationManager()
    private var cancellableSet: Set<AnyCancellable> = []

    //MARK: - Public Func

    func getDistance(to coordinates: [Double]) {
        locationManager.$lastLocation
            .flatMap { location in
                return Just(Int(location?.coordinate.distance(to: CLLocationCoordinate2D(latitude: coordinates.first!, longitude: coordinates.last!)) ?? 0))
            }
            .assign(to: \.distance, on: self)
            .store(in: &cancellableSet)
    }

    func invalidate() {
        cancellableSet.forEach { $0.cancel() }
        cancellableSet.removeAll()
    }
    

}
