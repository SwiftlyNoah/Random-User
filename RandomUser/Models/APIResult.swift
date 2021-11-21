//
//  APIResult.swift
//  RandomUser
//
//  Created by Noah Brauner on 11/21/21.
//

import Foundation

struct APIResult: Codable {
    let results: [User]
    let info: Info
}

struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}
// MARK: - Result
struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: DateOfBirth
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}
// MARK: - Dob
struct DateOfBirth: Codable {
    let date: String
    let age: Int
}
// MARK: - ID
struct ID: Codable {
    let name, value: String?
}
// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
    let postcode: MetadataType
    let coordinates: Coordinates
    let timezone: Timezone
}
// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}
// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}
// MARK: - Timezone
struct Timezone: Codable {
    let offset, timezoneDescription: String
    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}
// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}
// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}
// MARK: - Picture
struct Picture: Codable {
    // Use SDWebImageSwiftUI later and convert to url
    let large, medium, thumbnail: String
}

enum MetadataType: Codable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .int(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(MetadataType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}
