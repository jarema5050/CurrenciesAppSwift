//
//  Service.swift
//  currencies
//
//  Created by Jedrzej Sokolowski on 19/03/2020.
//  Copyright © 2020 JJ. All rights reserved.
//

import Foundation

class Service {
    
    
    static func getTableData(completion: @escaping(Any?) -> (), errorHandling: @escaping() -> (), decode: @escaping (Data) -> Any?, path: String){
        let urlString = path
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request){
                data, res, err in
                if let data = data {
                    let myResponse = decode(data)
                    if myResponse != nil {
                        completion(myResponse!)
                    }
                }
                if err != nil {
                    errorHandling()
                }
            }.resume()
        }
    }
}

struct Response : Decodable {
    let table : String
    let no : String
    let effectiveDate : String
    let rates :  [Rates]
    
}

struct Rates : Decodable {
    let currency : String
    let code : String
    let mid : Float?
    let bid: Float?
    let ask: Float?
}

struct CurrencyHistory : Decodable {
    let table : String
    let currency : String
    let code : String
    let rates :  [HistoryRates]
}

struct HistoryRates : Decodable {
    let no : String
    let effectiveDate : String
    let mid : Float?
    let bid: Float?
    let ask: Float?
}
