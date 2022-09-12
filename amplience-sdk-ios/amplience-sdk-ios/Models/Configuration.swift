//
//  Configuration.swift
//  Amplience
//
//

import Foundation

public class Configuration {
    public let hub: String
    public var isFresh: Bool = false
    
    public init(hub: String, isFresh: Bool) {
        self.hub = hub
        self.isFresh = isFresh
    }
}
