//
//  StationsListDTO.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Foundation

struct StationListDTO: Codable {
    let stationList: [StationDTO]

    enum CodingKeys: String, CodingKey {
        case stationList = "features"
    }
}
