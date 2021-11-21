//
//  APIManager.swift
//  RandomUser
//
//  Created by Noah Brauner on 11/21/21.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    public func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=10") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, urlError in
            guard let data = data, urlError == nil else {
                completion(.failure(urlError!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResult.self, from: data)
                
                completion(.success(result.results))
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
