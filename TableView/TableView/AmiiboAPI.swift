//
//  AmiiboAPI.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import Foundation

final class AmiiboAPI {
    
    static let shared = AmiiboAPI()
    
    func fetchAmiiboList() {
        let urlString = "https://www.amiiboapi.com/api/amiibo"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data else {
                print("Data was nil")
                return
            }
            
            guard let amiiboList = try? JSONDecoder().decode(AmiiboList.self, from: data) else {
                print("Couldn't decode form JSON")
                return
            }
            
            print(amiiboList.amiibo)
        }
        
        task.resume()
    }
}

struct AmiiboList: Codable {
    let amiibo: [Amiibo]
}

struct Amiibo: Codable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: AmiiboRelease
    let tail: String
    let type: String
}

struct AmiiboRelease: Codable {
    let au: String
    let eu: String
    let jp: String
    let na: String
}
