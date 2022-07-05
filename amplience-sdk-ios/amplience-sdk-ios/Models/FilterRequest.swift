//
//  FilterRequest.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

/**
 * [FilterRequest]
 *
 * @property filterBy - [FilterBy]/s to match to
 * If you specify multiple filters then all filters must be matched (AND).
 * @property sortBy - Sort by key. Can optionally override order.
 * @property parameters - Override depth, format and locale
 * @property page - Pagination
 */
public struct FilterRequest: Codable {
    public let filterBy: Array<FilterBy>
    public let sortBy: SortBy?
    public let page: Page?
    public var parameters: Parameters = Parameters()
    
    public init(filterBy: Array<FilterBy>, sortBy: SortBy?, page: Page?) {
        self.filterBy = filterBy
        self.sortBy = sortBy
        self.page = page
    }
}
