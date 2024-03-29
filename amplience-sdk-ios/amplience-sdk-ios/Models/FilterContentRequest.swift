//
//  FilterContentRequest.swift
//  amplience-sdk-ios
//
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
    public let filterBy: [FilterBy]
    public let sortBy: SortBy?
    public let page: Page?
    public var parameters: Parameters = Parameters()
    
    public init(filterBy: [FilterBy], sortBy: SortBy?, page: Page?) {
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
    public var depth: String = Depth.all.rawValue
    public var format: String = Format.inlined.rawValue
    public var locale: String?
}

public enum Depth: String {
    case all
}

public enum Format: String {
    case inlined
}
