//
//  RequestError.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 06/02/24.
//

import Foundation

enum RequestSuccess {
    case fromCache(WordElement)
    case fromAPI(WordElement)
}

enum RequestError: Error {
    case invalidURL
    case limitExceeded
    case wordNotFound
    case errorRequest(error: String)
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .limitExceeded:
            return "API request limit exceeded. Please try again later."
        case .wordNotFound:
            return "Word not found."
        case .errorRequest(let errorDescription):
                return errorDescription
        }
    }
}


