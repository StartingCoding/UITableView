//
//  AmiiboAPI.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import Foundation

final class AmiiboAPI {}

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
