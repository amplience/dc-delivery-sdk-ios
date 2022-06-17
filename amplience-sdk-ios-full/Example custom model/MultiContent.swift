//
//  MultiContent.swift
//  amplience-sdk-ios-full
//
//  Created by Maksym Paidych on 17.06.2022.
//

import Foundation
import Amplience

struct MultiContent: Codable {
    var text: String?
    var slides: [Slide] = []
    var banner: Banner?
    
    var itemsCount: Int {
        var counter: Int = 0
        
        if let _ = text {
            counter += 1
        }
        
        if let _ = banner {
            counter += 1
        }
        
        if !slides.isEmpty {
            counter += 1
        }
        
        return counter
    }
}
