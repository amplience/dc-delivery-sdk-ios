//
//  FilterContentResponse.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public struct FilterContentResponse: Codable {
    public let responses: [ContentResponse]
    let page: PageData
}

public struct PageData: Codable {
    let responseCount: Int
    let nextCursor: String?
}
