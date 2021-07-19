//
//  Service.swift
//  GenericsStarWars
//
//  Created by Barbara Barone on 18/07/21.
//

import Foundation

enum ServiceError: Error {
    case generic
}

class Service<T: Decodable> {
    func method(service :@escaping (Result<T, ServiceError>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://swapi.dev/api/people/1/") else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                do {
                    let decoded = try decode.decode(T.self, from: data)
                    service(.success(decoded))
                } catch {
                    service(.failure(.generic))
                }
            }
        }
        task.resume()
    }
}
