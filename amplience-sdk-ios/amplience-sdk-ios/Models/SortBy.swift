//
//  SortBy.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

enum Order: String, Codable {
    case ASC = "ASC"
    case DESC = "DESC"
}

/**
 * @property key - The sort key defined in the schema. The sort key must be specified in the
 * trait:sortable section of each schema that contains the filterable property.
 * @property order - Optional, can be [Order.ASC] (ascending) or [Order.DESC] (descending). ASC by default
 */
struct SortBy: Codable {
    let key: String
    var order: Order = Order.ASC
}
