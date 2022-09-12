//
//  ScaleFit.swift
//  amplience-sdk-ios
//
//

import Foundation

class ScaleFit {
    func toString() -> String {
        fatalError("Subclasses need to implement the `toString()` method.")
    }
}

class CenterFit: ScaleFit {
    override func toString() -> String {
        return "center"
    }

}

class PoiFit: ScaleFit {
    let x: Double
    let y: Double
    let w: Double
    let h: Double
    
    init(x: Double, y: Double, w: Double, h: Double) {
        self.x = x
        self.y = y
        self.w = w
        self.h = h
    }
    
    override func toString() -> String {
        return "poi&poi=\(x),\(y),\(w),\(h)"
    }
}
