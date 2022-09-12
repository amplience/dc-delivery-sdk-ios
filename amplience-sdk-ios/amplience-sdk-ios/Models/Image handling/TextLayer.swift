//
//  Textlayer.swift
//  amplience-sdk-ios
//
//

import Foundation

class TextLayer: Layer {

    var text: String
    var fontSize: Int? // defaults to 10 if not specifeid
    var fontFamily: String? // If you don't specify a font family or specify a font that is not installed on your account then it will default to Helevetica.
    var fontStyle: FontStyle?
    var fontWeight: Int? // varid varues are from 100 to 900 in multiples of 100.
    var fontStretch: FontStretch?
    var textColor: TextColor?
    var textDecoration: Decoration?
    var textAlign: String?
    
    init(text: String) {
        self.text = text
    }
    
    func toQuery() -> String {
        var builder = "["
        var firstQuery = true

        func addQuery(query: String) {
            if firstQuery {
                builder.append("?")
                firstQuery = false
            } else {
                builder.append("&")
            }
            builder.append(query)
        }

        if fontSize != nil {
            addQuery(query: "fontSize=\(fontSize!)")
        }
        
        if fontFamily != nil {
            addQuery(query: "fontFamily=\(fontFamily!)")
        }
        
        if fontStyle != nil {
            addQuery(query: "fontStyle=\(fontStyle!)")
        }
        
        if fontWeight != nil {
            addQuery(query: "fontWeight=\(fontWeight!)")
        }
        
        if fontStretch != nil {
            addQuery(query: "fontStretch=\(fontStretch!)")
        }
        
        if textColor != nil {
            addQuery(query: "textColor=\(textColor!)")
        }
        
        if textDecoration != nil {
            addQuery(query: "textDecoration=\(textDecoration!)")
        }
        
        if textAlign != nil {
            addQuery(query: "textAlign=\(textAlign!)")
        }
        
        builder.append("]")
        return builder
    }

}
