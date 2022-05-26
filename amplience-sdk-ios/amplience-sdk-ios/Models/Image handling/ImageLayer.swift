//
//  ImageLayer.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation

class ImageLayer: Layer {
    var src: String
    var width: Int? = nil
    var height: Int? = nil
    var topPx: Int? = nil
    var topPercent: Int? = nil
    var leftPx: Int? = nil
    var leftPercent: Int? = nil
    var bottomPx: Int? = nil
    var bottomPercent: Int? = nil
    var rightPx: Int? = nil
    var rightPercent: Int? = nil
    var anchor: Anchor? = nil
    var opacity: Int? = nil

    init(src: String) {
      self.src = src
    }
    
    func toQuery() -> String {
        var builder = "["
        var firstQuery = true

        func addQuery(query: String) {
            if (firstQuery) {
                builder.append("?")
                firstQuery = false
            } else {
                builder.append("&")
            }
            builder.append(query)
        }

        addQuery(query: "src=$src")
        if width != nil { addQuery(query: "w=\(width!)") }
        if height != nil { addQuery(query: "h=\(height!)") }
        if topPx != nil { addQuery(query: "top=\(topPx!)") }
        if topPercent != nil { addQuery(query: "top=\(topPercent!)") }
        if leftPx != nil { addQuery(query: "left=\(leftPx!)") }
        if leftPercent != nil { addQuery(query: "left=\(leftPercent!)") }
        if bottomPx != nil { addQuery(query: "bottom=\(bottomPx!)") }
        if bottomPercent != nil { addQuery(query: "bottom=\(bottomPercent!)") }
        if rightPx != nil { addQuery(query: "right=\(rightPx!)") }
        if rightPercent != nil { addQuery(query: "right=\(rightPercent!)") }
        if anchor != nil { addQuery(query: "anchor=\(anchor!)") }
        if opacity != nil { addQuery(query: "opacity=\(opacity!)") }

        builder.append("]")
        return builder
    }
}
