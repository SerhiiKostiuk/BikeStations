//
//  StationsListViewModel.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Combine
import Foundation

class StationsListViewModel: ObservableObject {

    //MARK: - Static Properties

    static private let path = "https://urldefense.proofpoint.com/v2/url?u=http-3A__www.poznan.pl_mim_plan_map-5Fservice.html-3Fmtype-3Dpub-5Ftransport-26co-3Dstacje-5Frowerowe&d=DwMFaQ&c=slrrB7dE8n7gBJbeO0g-IQ&r=7KqbImkapN2a2V0t8lnd0sdXPhKRqZfWKdtKYdfyYLk&m=GOeP-I9HkpMWrrqggwcmpuLduk0C9umq_zlZsgPe3QA&s=ibzScnWQ_bOFrc4U7zkaME_RsEWE1ZqLfu8XeepbX6I&e="

    //MARK: - @Published Properties

    @Published var models: [StationDTO] = []

    //MARK: - Private Properties

    private var cancellableSet: Set<AnyCancellable> = []
    private let networkClient = NetworkClient()

    //MARK: - Public Func

    func getList() {
        let cancellable = networkClient.getStationsList(path: StationsListViewModel.path).eraseToAnyPublisher()
            .sink { error in
                print(error)
            } receiveValue: {[weak self] dto in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    self.models = dto.stationList
                }
            }
        cancellableSet.insert(cancellable)

    }

    func invalidate() {
        cancellableSet.forEach { $0.cancel() }
        cancellableSet.removeAll()
    }
}
