//
//  ListContentRequest.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

public struct ListContentRequest: Codable {
    let requests: [ContentRequest]
    var parameters = Parameters()
}
