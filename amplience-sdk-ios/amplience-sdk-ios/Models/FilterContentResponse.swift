//
//  FilterContentResponse.swift
//  amplience-sdk-ios
//
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
