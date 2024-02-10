//
//  DictionaryViewModel.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 06/02/24.
//

import Foundation
import SwiftUI

class DictionaryViewModel: ObservableObject {
    
    @Published var definition: WordElement?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var wordDataFormatted: [PartOfSpeechData] = []
    @Published var audioAvailable: Bool = false
    @Published var showSaleView: Bool = false
    
    private var service = WordService()
    private var audioManager = AudioManager()
    
    private let requestManager = RequestManager.shared
    private var cacheManager = CacheManager.shared
        
    func searchWord(_ word: String) {
        requestManager.resetRquestNewDay()
        setupSearch()

        Task {
            do {

                let result = try await service.getDefinition(word: word)
                
                DispatchQueue.main.async {
                    switch result {
                        
                        case .success(let sucessResult):
                        
                            switch sucessResult {
                                
                                case.fromCache(let wordCacheElement):
                                    self.definition = wordCacheElement
                                    self.getpartOfSpeech()
                                    print("vim do cachê")
                                
                                case.fromAPI(let wordElement):
                                    self.definition = wordElement
                                    self.getpartOfSpeech()
                                    print("vim da API")
                                    print("requests: \(self.requestManager.requestCount)")
                                }
                            self.isLoading = false
                        
                        
                        case .failure(let error):
                        switch error {
                            case .limitExceeded:
                                self.limitExceededScreen()
                                
                                self.errorMessage = error.errorMessage
                                    print("Excedeu")
                            case .wordNotFound:
                                self.errorMessage = error.errorMessage
                                    print("N existe")
                            default:
                                self.errorMessage = error.errorMessage
                            }
                            self.isLoading = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = RequestError.errorRequest(error: error.localizedDescription).errorMessage
                    self.isLoading = false
                }
            }
        }
    }

    func setupSearch() {
        self.isLoading = true
        self.errorMessage = nil
        self.definition = nil
//        updateAudioAvailability()
    }
    
    func getpartOfSpeech() {
        guard let definition = definition else { return }
        var formattedData: [PartOfSpeechData] = []
        
        for part in definition.meanings{
            if let partOfSpeech = part.partOfSpeech {
                var definitionsArray: [Definition] = []
                var count = 0
                
                for def in part.definitions ?? [] {
                    guard count < 3 else { continue }
                    
                    if let defitinion = def.definition {
                        let example = def.example
                        definitionsArray.append(Definition(definition: defitinion, example: example))
                        count += 1
                    }
                }
                formattedData.append(PartOfSpeechData(partOfSpeech: partOfSpeech, deifinitions: definitionsArray))
            }
        }
        self.wordDataFormatted = formattedData
    }
    
    func getFirstAudioURL() -> URL? {
        guard let definition = definition else {
            self.audioAvailable = false
            return nil
        }
        
        for phonetic in definition.phonetics {
            if let audioString = phonetic.audio, !audioString.isEmpty {
                if let aurioUrl = URL(string: audioString){
                    self.audioAvailable = true
                    return aurioUrl
                } else {
                    print("Invalid url format...")
                }
            }
        }
        self.audioAvailable = false
        return nil
    }
    
    func playSound(_ url: URL){
        audioManager.playSoundFromURL(url: url)
    }
    
    func updateAudioAvailability(){
        if getFirstAudioURL() != nil {
            self.audioAvailable = true
        } else {
            self.audioAvailable = false
        }

    }
        
    func limitExceededScreen() {
        self.showSaleView = true
        print("Atingiu")
    }

}
