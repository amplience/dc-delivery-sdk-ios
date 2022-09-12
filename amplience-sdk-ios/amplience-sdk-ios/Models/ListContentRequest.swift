//
//  ListContentRequest.swift
//  amplience-sdk-ios
//
//

import Foundation

public struct ListContentRequest: Codable {
    let requests: [ContentRequest]
    var parameters = Parameters()
}
