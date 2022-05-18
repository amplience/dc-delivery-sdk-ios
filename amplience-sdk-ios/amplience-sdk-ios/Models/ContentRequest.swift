//
//  ContentRequest.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

struct ContentRequest: Codable {
    let requests: Array<Request>
    var parameters = Parameters()
}
