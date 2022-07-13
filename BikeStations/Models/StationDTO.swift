//
//  StationDTO.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Foundation
import MapKit

struct StationDTO: Codable, Hashable, Equatable {
    let geometry: GeometryDTO
    let id: String
    let type: StationType
    let properties: PropertiesDTO

    static func == (lhs: StationDTO, rhs: StationDTO) -> Bool {
        return lhs.id == rhs.id
    }
}

struct GeometryDTO: Codable, Hashable {
    let coordinates: [Double]
    let type: GeometryType
}

enum GeometryType: String, Codable, Hashable {
    case Point
}

enum StationType: String, Codable, Hashable {
    case Feature
}

struct PropertiesDTO: Codable, Hashable {
    let freeRacks: String
    let bikes: String
    let label: String
    let bikeRacks: String
    let updated: String

    enum CodingKeys: String, CodingKey {
        case freeRacks = "free_racks"
        case bikes
        case label
        case bikeRacks = "bike_racks"
        case updated
    }
}
