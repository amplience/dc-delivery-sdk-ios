//
//  FilterBy.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

/**
 * [FilterBy] properties must be specified in the trait:filterable section of a content type schema
 *
 * @property path - The JSON pointer format path to the filterable property to use as a filter.
 * @property value - The value to match against
 */
public struct FilterBy: Codable {
    let path: String
    let value: String
}
