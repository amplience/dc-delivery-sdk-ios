//
//  ContentResponse.swift
//  amplience-sdk-ios
//
//

import Foundation

private class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()

    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}

public struct ContentResponse: Codable {
    public let content: [String: AnyCodable]
    public let linkedContent: [[String: AnyCodable]]?
}
