//
//  Parameters.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

/**
 * @property depth - can be root or all
 * @property format - can be inlined or linked
 * @property locale
 */
struct Parameters: Codable {
    let depth: String = "all"
    let format: String = "inlined"
    var locale: String?
}
