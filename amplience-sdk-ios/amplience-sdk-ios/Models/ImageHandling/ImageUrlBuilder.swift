//
//  ImageUrlBuilder.swift
//  amplience-sdk-ios
//
//

import Foundation

public class ImageUrlBuilder {
    private var width: Int?
    private var height: Int?
    private var maxWidth: Int?
    private var maxHeight: Int?
    private var quality: Int?
    private var defaultQuality: Bool?
    private var scaleMode: ScaleMode?
    private var scaleFit: ScaleFit?
    private var resizeAlgorithm: ResizeAlgorithm?
    private var upscale: Upscale?
    private var format: ContentFormat?
    private var autoFormat: Bool?
    private var formatQuality: FormatQuality?

    public init() {}
    
    func setWidth(width: Int) { self.width = width }
    func setHeight(height: Int) { self.height = height }
    func setMaxWidth(maxWidth: Int) { self.maxWidth = maxWidth }
    func setMaxHeight(maxHeight: Int) { self.maxHeight = maxHeight }
    func setQuality(quality: Int) { self.quality = quality }
    func setDefaultQuality() {
        self.defaultQuality = true
        quality = nil
    }
    
    func scaleMode(scaleMode: ScaleMode) {
        self.scaleMode = scaleMode
        if let s = scaleMode as? Clamp {
            self.width = s.width
            self.height = s.height
        }
    }
    
    func setScaleFit(scaleFit: ScaleFit) { self.scaleFit = scaleFit }
    func resize(resizeAlgorithm: ResizeAlgorithm) { self.resizeAlgorithm = resizeAlgorithm }
    func setUpscale(upscale: Upscale) { self.upscale = upscale }
    
    /**
     * @param format - choose from 6 [Format]s
     * @param quality - select a quality percentage 0-100 (does not apply to [Format.Gif] or [Format.Bmp])
     */
    func format(format: ContentFormat, quality: Int? = nil) {
        self.format = format
        if format == .Webp {
            formatQuality = Webp(quality: quality)
        } else if format == .Jp2 {
            formatQuality = Jp2(quality: quality)
        } else if format == .Jpeg {
            formatQuality = Jpeg(quality: quality)
        } else if format == .Png {
            formatQuality = Png(quality: quality)
        } else {
            formatQuality = nil
        }
        
    }

    func build() -> String {
        var builder = String()
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
        
        if width != nil {
            addQuery(query: "w=\(width!)")
        }
        if height != nil {
            addQuery(query: "h=\(height!)")
        }
        if maxWidth != nil {
            addQuery(query: "maxW=\(maxWidth!)")
        }
        if maxHeight != nil {
            addQuery(query: "maxH=\(maxHeight!)")
        }
        if scaleMode != nil {
            addQuery(query: "sm=\(scaleMode!)")
        }
        if scaleFit != nil {
            addQuery(query: "scalefit=\(scaleFit!)")
        }
        if resizeAlgorithm != nil {
            addQuery(query: "filter=\(resizeAlgorithm!)")
        }
        if upscale != nil {
            addQuery(query: "upscale=\(upscale!)")
        }
        if format != nil {
            addQuery(query: "fmt=\(format!)")
        }
        if formatQuality != nil {
            addQuery(query: formatQuality!.toString())
        }
        
        return builder
    }
}
