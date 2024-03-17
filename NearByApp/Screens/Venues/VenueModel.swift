//
//  VenueModel.swift
//  NearByApp
//
//  Created by Sonam on 17/03/24.
//

// MARK: - VenuesModel
struct VenuesModel: Decodable {
    let venues: [Venue]?
    let meta: Meta?
}

// MARK: - Meta
struct Meta: Decodable {
    let total, took, page, perPage: Int?
    let geolocation: Geolocation?
}

// MARK: - Geolocation
struct Geolocation: Decodable {
    let lat, lon: Double?
    let city, state, country, postalCode: String?
    let displayName: String?
    let range: String?
}

// MARK: - Venue
struct Venue: Decodable {
    let nameV2, postalCode,city, name: String?
    let timezone: String?
    let url: String?
    let score: Int?
    let location: Location?
    let address: String?
    let hasUpcomingEvents: Bool?
    let numUpcomingEvents: Int?
    let slug: String?
    let stats: Stats?
    let id, popularity: Int?
    let metroCode, capacity: Int?
}

// MARK: - Location
struct Location: Decodable {
    let lat, lon: Double?
}

// MARK: - Stats
struct Stats: Decodable {
    let eventCount: Int?
}
