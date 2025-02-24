//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Ricardo Montesinos on 23/02/25.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    private let session = URLSession.shared

    // MARK: - General Request Method
    func performRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("Bearer \(APIEndpoints.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        task.resume()
    }
}
