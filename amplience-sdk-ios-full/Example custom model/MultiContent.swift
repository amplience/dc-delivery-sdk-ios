//
//  MultiContent.swift
//  amplience-sdk-ios-full
//
//

import Foundation
import Amplience

struct MultiContent: Codable {
    var text: String?
    var slides: [Slide] = []
    var banner: Banner?
    var video: AmplienceVideo?

    var itemsCount: Int {
        var counter: Int = 0
        if text != nil {
            counter += 1
        }
        if banner != nil {
            counter += 1
        }
        if !slides.isEmpty {
            counter += 1
        }
        if video != nil {
            counter += 1
        }
        return counter
    }
}
