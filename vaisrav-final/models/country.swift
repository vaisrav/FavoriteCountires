//
//  country.swift
//  vaisrav-final
//
//  Created by Graphic on 2023-07-11.
//

import Foundation

struct Name : Codable {
    var common : String
}

struct Flag : Codable {
    var png : String
}

struct CapitalInfo : Codable {
    var latlng : [Double]
}

struct Country : Codable {
    var name : Name
    var capital : [String]
    var population : Int
    var area : Double
    var flags : Flag
    var capitalInfo : CapitalInfo
}
