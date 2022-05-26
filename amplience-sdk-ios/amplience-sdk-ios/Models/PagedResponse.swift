//
//  PagedResponse.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public struct PagedResponse: Codable {
    let responses: Array<ContentResponse>
    let page: PageData
}
