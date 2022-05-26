//
//  Page.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

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
    let size: Int
    let cursor: String?
}
