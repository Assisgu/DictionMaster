//
//  WordService.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 05/02/24.
//

import Foundation
import SwiftUI

struct WordService {
    
    private let networkManager = NetworkManager.shared
    private let cacheManager = CacheManager.shared
    private let requestManager = RequestManager.shared
    
    var cache: [String: WordElement] = [:]
    

    private mutating func saveCahe(){
        cacheManager.saveCache(cache)
    }
    
    mutating func loadCache(){
        if let decodeCache = cacheManager.loadCache() {
            cache = decodeCache
        }
    }
    
    
    mutating func getDefinition(word: String) async throws -> Result<RequestSuccess, RequestError> {
        
        loadCache()
        
        if let wordInCache = cache[word.lowercased()] {
            print("Achei, recuperei dados salvos atualmente : \(cache.count)")
            print(cache.keys)
            return .success(.fromCache(wordInCache))

        } else {
            
            do {
                if requestManager.isRequestLimitExceeded(){
                    return.failure(.limitExceeded)
                }
                let result = try await networkManager.fetchData(word: word)
                
                switch result {
                case .success(let wordElements):
                    guard let firstWordElement = wordElements.first else { return .failure(.wordNotFound) }
                    cache[word.lowercased()] = firstWordElement
                    saveCahe()
                    print("Salvei...")
                    requestManager.incrementRequestCount()
                    return .success(.fromAPI(firstWordElement))

                    
                case .failure(let error):
                    return.failure(error)
                }
            }
            catch {
                throw error
            }
           
        }

    }
    
    
    
    
    
    
}


