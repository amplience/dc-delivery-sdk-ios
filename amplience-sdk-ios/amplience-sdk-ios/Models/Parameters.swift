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
public struct Parameters: Codable {
    public var depth: String = "all"
    public var format: String = "inlined"
    public var locale: String?
}
