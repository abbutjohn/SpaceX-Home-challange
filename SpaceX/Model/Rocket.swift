//
//  Rocket.swift
//  SpaceX
//
//  Created by Abbut john on 14/06/2021.
//

import Foundation

struct Rocket: Codable {
    let id: String
    let name: String
    let success_rate_pct: Int
    let first_flight: String
    let active: Bool
    let flickr_images: [String]
    let country: String
    let description: String
    let cost_per_launch: Int
    let wikipedia: String
}
