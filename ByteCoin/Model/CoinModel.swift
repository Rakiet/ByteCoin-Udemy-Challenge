//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Piotr Żakieta on 15/04/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel{
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}

struct CoinData:Codable{
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
