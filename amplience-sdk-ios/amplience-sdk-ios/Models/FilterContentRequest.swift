//
//  FilterContentRequest.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

/**
 * [FilterContentRequest]
 *
 * @property filterBy - [FilterBy]/s to match to
 * If you specify multiple filters then all filters must be matched (AND).
 * @property sortBy - Sort by key. Can optionally override order.
 * @property parameters - Override depth, format and locale
 * @property page - Pagination
 */
public struct FilterContentRequest: Codable {
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

/**
 * [Page] used in pagination requests
 *
 * @property size - The number of items to be returned in each request.
 * The maximum page size is 12. If size is not specified then the default
 * page size of 12 will be used.
 *
 * @property cursor (optional) - The starting point for the next request. Returned in
 * the nextCursor property of the response if there are further results.
 */
public struct Page: Codable {
    public let size: Int
    public let cursor: String?
}

/**
 * @property depth - can be root or all
 * @property format - can be inlined or linked
 * @property locale
 */
public struct Parameters: Codable {
    public var depth: String = "all"
    public var format: String = "inlined"
    public var locale: String?
}
