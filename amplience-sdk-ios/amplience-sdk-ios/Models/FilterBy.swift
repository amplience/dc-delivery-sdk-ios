//
//  FilterBy.swift
//  amplience-sdk-ios
//
//

import Foundation

/**
 * [FilterBy] properties must be specified in the trait:filterable section of a content type schema
 *
 * @property path - The JSON pointer format path to the filterable property to use as a filter.
 * @property value - The value to match against
 */
public struct FilterBy: Codable {
    public let path: String
    public let value: String
    
    public init(path: String, value: String) {
        self.path = path
        self.value = value
    }
}
