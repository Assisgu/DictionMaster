//
//  NetworkManager.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 05/02/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    private init (){}

    func handleResponse(data: Data, response: URLResponse?) throws -> Result<[WordElement], RequestError> {
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
            return .failure(.wordNotFound)
        }
        
        let wordObject = try JSONDecoder().decode([WordElement].self, from: data)
        return .success(wordObject)
    }
    
    
    func fetchData(word: String) async throws -> Result<[WordElement], RequestError> {

        guard let url = URL(string: baseURL + word.lowercased()) else { return.failure(.invalidURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return try handleResponse(data: data, response: response)
        } catch {
            return .failure(.errorRequest(error: error.localizedDescription))
        }
    }
    

}

