//
//  FormatQuality.swift
//  amplience-sdk-ios
//
//

import Foundation

class FormatQuality: Codable {
    var quality: Int?

    func toString() -> String {
        fatalError("Subclasses need to implement the `toString()` method.")
    }
    
    init(quality: Int?) {
        self.quality = quality
    }
}

class Webp: FormatQuality {
    override func toString() -> String {
        return "fmt.webp.qlt=\(quality!)"
    }
}

class Jp2: FormatQuality {
    override func toString() -> String {
        return "fmt.jp2.qlt=\(quality!)"
    }
}

class Jpeg: FormatQuality {
    override func toString() -> String {
        return "fmt.jpeg.qlt=\(quality!)"
    }
}

class Png: FormatQuality {
    override func toString() -> String {
        return "fmt.png.qlt=\(quality!)"
    }
}
