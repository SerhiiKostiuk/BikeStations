//
//  NetworkClient.swift
//  BikeStations
//
//  Created by skostiuk on 13.07.2022.
//

import Foundation
import Combine

enum ApiError: Error {
    case somethingWentWrong
}

protocol ApiClient {
    func getStationsList(path: String) -> AnyPublisher<StationListDTO, Error>
}

final class NetworkClient: ApiClient {

    func getStationsList(path: String) -> AnyPublisher<StationListDTO, Error> {

        return AnyPublisher(Future { promise in
            guard let url = URL(string: path) else {
                promise(.failure(ApiError.somethingWentWrong))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let urlResponse = response as? HTTPURLResponse else {
                    promise(.failure(ApiError.somethingWentWrong))
                    return
                }

                if urlResponse.statusCode == 200,
                   let dto = try? JSONDecoder().decode(StationListDTO.self, from: data)  {
                    promise(.success(dto))
                } else {
                    promise(.failure(ApiError.somethingWentWrong))
                }
            }

            task.resume()

        })

    }


}
