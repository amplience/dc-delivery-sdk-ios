//
//  AmplienceManager.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation

class AmplienceManager {
    static let shared = AmplienceManager()
    
    private init() {}
    
    var hub: String?
    
    var generateBaseUrl: String {
        get {
            return "https://\(hub!).cdn.content.amplience.net"
        }
    }
    
}
