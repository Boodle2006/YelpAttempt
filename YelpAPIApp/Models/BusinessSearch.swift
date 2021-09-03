//
//  BusinessSearch.swift
//  YelpAPIApp
//
//  Created by James Goldston on 9/3/21.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
