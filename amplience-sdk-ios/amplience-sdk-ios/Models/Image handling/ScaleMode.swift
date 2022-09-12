//
//  ScaleMode.swift
//  amplience-sdk-ios
//
//

import Foundation

class ScaleMode {
    func toString() -> String {
        fatalError("Subclasses need to implement the `toString()` method.")
    }
}

class CropToFit: ScaleMode { override func toString() -> String { return "c" } }
class Stretch: ScaleMode { override func toString() -> String { return "s" } }
class TopLeft: ScaleMode { override func toString() -> String { return "tl" } }
class TopCenter: ScaleMode { override func toString() -> String { return "tc" } }
class TopRight: ScaleMode { override func toString() -> String { return "tr" } }
class MiddleLeft: ScaleMode { override func toString() -> String { return "ml" } }
class MiddleCenter: ScaleMode { override func toString() -> String { return "mc" } } // Default
class MiddleRight: ScaleMode { override func toString() -> String { return "mr" } }
class BottomLeft: ScaleMode { override func toString() -> String { return "bl" } }
class BottomCenter: ScaleMode { override func toString() -> String { return "bc" } }
class BottomRight: ScaleMode { override func toString() -> String { return "br" } }

class Clamp: ScaleMode {
    let width: Int
    let height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    override func toString() -> String { return "clamp" }
}

class AspectRatio: ScaleMode {
    var ratio: String
    
    init(ratio: String) {
        self.ratio = ratio
    }
    
    override func toString() -> String { return "aspect&aspect=\(ratio)" }
}

class Edge: ScaleMode {
    var type: EdgeType
    var length: Int
    init(type: EdgeType, length: Int) {
        self.type = type
        self.length = length
    }
    override func toString() -> String { return "edge&resize.edge=\(type)&resize.edge.length=\(length)" }
    
}
