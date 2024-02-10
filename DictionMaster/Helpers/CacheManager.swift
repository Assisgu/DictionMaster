//
//  CacheManager.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 07/02/24.
//

import Foundation

class CacheManager{
    
    static let shared = CacheManager()
    

    private let cacheKey = "CachedWordElements"
    
    func saveCache(_ cache: [String: WordElement]) {
        do {
            let data = try JSONEncoder().encode(cache)
            UserDefaults.standard.setValue(data, forKey: cacheKey)
        } catch {
            print("Erro ao codificar o elemento.")
        }
    }
    
    func loadCache() -> [String: WordElement]? {
        if let data = UserDefaults.standard.data(forKey: cacheKey),
           let decodedCache = try? JSONDecoder().decode([String: WordElement].self, from: data) {
            return decodedCache
        }
        return nil
    }
    
    func getCacheWordd(for word: String) -> WordElement? {
        if let wordCache = loadCache() {
            return wordCache[word]
        }
        return nil
    }
    
}
