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
struct FilterRequest: Codable {
    let filterBy: Array<FilterBy>
    let sortBy: SortBy?
    let page: Page?
    let parameters: Parameters = Parameters()
}
