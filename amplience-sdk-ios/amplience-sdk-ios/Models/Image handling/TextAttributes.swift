//
//  TextAttributes.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 26/05/2022.
//

import Foundation

enum FontStyle: String {
  case Normal = "normal"
  case Italic = "italic"
  case Oblique = "oblique"
}

enum FontStretch: String {
  case UltraCondensed = "ultra-condensed"
  case ExtraCondensed = "extra-condensed"
  case Condensed = "condensed"
  case SemiCondensed = "semi-condensed"
  case Normal = "normal"
  case SemiExpanded = "semi-expanded"
  case Expanded = "expanded"
  case ExtraExpanded = "extra-expanded"
  case UltraExpanded = "ultra-expanded"
}

class TextColor {
    func toString() -> String {
        fatalError("Subclasses need to implement the `toString()` method.")
    }
}

class RGB: TextColor {
    let red: Int
    let green: Int
    let blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    override func toString() -> String {
        return "rgb(\(red),\(green),\(blue))"
    }
}

class ColourName: TextColor {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    override func toString() -> String {
        return name
    }
}

class Hex: TextColor {
    var hex: String
    
    init(hex: String) {
        self.hex = hex
    }
    
    override func toString() -> String {
        return hex
    }
}

enum Decoration: String {
  case Underline = "underline"
  case Overline = "overline"
  case LineThrough = "linethrough"
}
