//
//  RequestManager.swift
//  DictionMaster
//
//  Created by Gustavo Assis on 08/02/24.
//

import Foundation

class RequestManager {
    
    static let shared = RequestManager()
    
    private let maxRequestCount: Int = 5
    
    var requestCount: Int {
        didSet {
            UserDefaults.standard.set(requestCount, forKey: "RequestCount")
        }
    }
    
    init() {
        self.requestCount = UserDefaults.standard.integer(forKey: "RequestCount")
    }
    
    func incrementRequestCount() {
           requestCount += 1
       }
    
    func isRequestLimitExceeded() -> Bool {
         return requestCount >= maxRequestCount
     }
    
    func resetRquestNewDay(){
        
        let currentDate = Date()
        guard let lastResetDate = UserDefaults.standard.object(forKey: "LastResetDate") as? Date else {
                 UserDefaults.standard.set(currentDate, forKey: "LastResetDate")
                 return
             }
             
        let calendar = Calendar.current
             if !calendar.isDate(currentDate, inSameDayAs: lastResetDate) {
                 requestCount = 0
                 UserDefaults.standard.set(currentDate, forKey: "LastResetDate")
             }
         }
}
