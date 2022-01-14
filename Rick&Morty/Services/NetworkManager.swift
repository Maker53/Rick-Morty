//
//  NetworkManager.swift
//  Rick&Morty
//
//  Created by Станислав on 13.01.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

private func fetch<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
    guard let url = URL(string: url) else {
        completion(.failure(.invalidURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        
        do {
            let type = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(type))
            }
        } catch {
            completion(.failure(.decodingError))
        }
    }.resume()
}
