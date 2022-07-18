//
//  ImageUrlBuilder.swift
//  amplience-sdk-ios
//
//  Created by Dylan McKee on 18/05/2022.
//

import Foundation


public class ImageUrlBuilder {
    private var width: Int? = nil
    private var height: Int? = nil
    private var maxWidth: Int? = nil
    private var maxHeight: Int? = nil
    private var quality: Int? = nil
    private var defaultQuality: Bool? = nil
    private var scaleMode: ScaleMode? = nil
    private var scaleFit: ScaleFit? = nil
    private var resizeAlgorithm: ResizeAlgorithm? = nil
    private var upscale: Upscale? = nil
    private var format: ContentFormat? = nil
    private var autoFormat: Bool? = nil
    private var formatQuality: FormatQuality? = nil
    private var crop: Crop? = nil
    private var edgeCrop: EdgeCrop? = nil
    private var preCrop: Crop? = nil
    private var preEdgeCrop: EdgeCrop? = nil
    private var rotateDegrees: Int? = nil
    private var rgb: (r: Int, g: Int, b: Int)? = nil
    private var preRotate: Bool? = nil
    private var flipH: Bool = false
    private var flipV: Bool = false
    private var dpi: Int? = nil
    private var dpiFilter: DpiFilter? = nil
    private var strip: Bool = false
    private var chromaSubsampling: Bool = true
    private var colorSpace: ColorSpace? = nil
    private var unsharp: Unsharp? = nil
    private var compositeMode: CompositeMode? = nil
    private var backgroundRgb: (r: Int, g: Int, b: Int)? = nil
    private var indexed: Bool = false
    private var paletteSize: Int? = nil
    private var dithered: Bool = true
    private var blur: Blur? = nil
    private var reduceNoise: Int? = nil
    private var gamma: Float? = nil
    private var hue: Int? = nil
    private var saturation: Int? = nil
    private var brightness: Int? = nil
    private var layers: Array<Layer> = Array()
    
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
    
    func crop(
        x: Int, // offset from the top left of the image
        y: Int, // offset from the top of the image
        w: Int, // width of the selection
        h: Int // height of the selection)
    ) {
        crop = Crop(x: x, y: y, w: w, h: h)
    }
    
    func edgeCrop(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int
    ) {
        edgeCrop = EdgeCrop(left: left, top: top, right: right, bottom: bottom)
    }
    
    func preCrop(
        x: Int, // offset from the top left of the image
        y: Int, // offset from the top of the image
        w: Int, // width of the selection
        h: Int // height of the selection)
    ) {
        preCrop = Crop(x: x, y: y, w: w, h: h)
    }
    
    func preEdgeCrop(
        left: Int,
        top: Int,
        right: Int,
        bottom: Int
    ) {
        preEdgeCrop = EdgeCrop(left: left, top: top, right: right, bottom: bottom)
    }
    
    func rotate(angle: Int) {
        rotateDegrees = angle
        preRotate = false
    }
    
    func rotate(angle: Int, r: Int, g: Int, b: Int) {
        rotateDegrees = angle
        rgb = (r: r, g: g, b: b)
        preRotate = false
    }
    
    func preRotate(angle: Int) {
        rotateDegrees = angle
        preRotate = true
    }
    
    func preRotate(angle: Int, r: Int, g: Int, b: Int) {
        rotateDegrees = angle
        rgb = (r: r, g: g, b: b)
        preRotate = true
    }
    
    func flipHorizontally() { flipH = true }
    func flipVertically() { flipV = true }
    
    func dpi(dpi: Int, dpiFilter: DpiFilter? = nil) {
        self.dpi = dpi
        self.dpiFilter = dpiFilter
    }
    
    func setStrip() { strip = true }
    
    func setChromaSubsampling(chromaSubsampling: Bool) { self.chromaSubsampling = chromaSubsampling }
    
    func setColorSpace(colorSpace: ColorSpace) { self.colorSpace = colorSpace }
    func setUnsharp(unsharp: Unsharp) { self.unsharp = unsharp }
    func setCompositeMode(compositeMode: CompositeMode) { self.compositeMode = compositeMode }
    func setBackground(red: Int, green: Int, blue: Int) {
        backgroundRgb = (r: red, g: green, b: blue)
    }
    
    /**
     * Specify if the PNG image should be indexed. Indexed PNGs have a color palette rather than
     * storing color information with the pixel data.
     */
    func index(indexed: Bool, paletteSize: Int? = nil) {
        self.indexed = indexed
        self.paletteSize = paletteSize
    }
    
    func dither(dithered: Bool) { self.dithered = dithered }
    func blur(radius: Int, sigma: Int) { blur = Blur(radius: radius, sigma: sigma) }
    func reduceNoise(reduceNoise: Int) { self.reduceNoise = reduceNoise }
    func gamma(gamma: Float) { self.gamma = gamma }
    func hsb(hue: Int, saturation: Int, brightness: Int) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
    }
    
    func addImageLayer(
        src: String,
        width: Int? = nil,
        height: Int? = nil,
        topPx: Int? = nil,
        topPercent: Int? = nil,
        leftPx: Int? = nil,
        leftPercent: Int? = nil,
        bottomPx: Int? = nil,
        bottomPercent: Int? = nil,
        rightPx: Int? = nil,
        rightPercent: Int? = nil,
        anchor: Anchor? = nil,
        opacity: Int? = nil
    ) {
        let il = ImageLayer(src: src)
        il.width = width
        il.height = height
        il.topPx = topPx
        il.topPercent = topPercent
        il.leftPx = leftPx
        il.leftPercent = leftPercent
        il.bottomPx = bottomPx
        il.bottomPercent = bottomPercent
        il.rightPx = rightPx
        il.rightPercent = rightPercent
        il.anchor = anchor
        il.opacity = opacity
        layers.append(il)
    }

    func addTextLayer(
        text: String,
        fontSize: Int? = nil, // defaults to 10
        fontFamily: String? = nil, // If you don't specify a font family, or specify a font that is not installed on your account, then it will default to Helevetica.
        fontStyle: FontStyle? = nil,
        fontWeight: Int? = nil, // Valid values are from 100 to 900 in multiples of 100.
        fontStretch: FontStretch? = nil,
        textColor: TextColor? = nil,
        textDecoration: Decoration? = nil,
        textAlign: String? = nil
    ) {
        let tl = TextLayer(text: text)
        tl.fontSize = fontSize
        tl.fontFamily = fontFamily
        tl.fontStyle = fontStyle
        tl.fontWeight = fontWeight
        tl.fontStretch = fontStretch
        tl.textColor = textColor
        tl.textDecoration = textDecoration
        tl.textAlign = textAlign
        layers.append(tl)
    }
    
    
    func build() -> String {
        var builder = String()
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
        
        if (width != nil) {
            addQuery(query: "w=\(width!)")
        }
        if (height != nil) {
            addQuery(query: "h=\(height!)")
        }
        if (maxWidth != nil) {
            addQuery(query: "maxW=\(maxWidth!)")
        }
        if (maxHeight != nil) {
            addQuery(query: "maxH=\(maxHeight!)")
        }
        if (scaleMode != nil) {
            addQuery(query: "sm=\(scaleMode!)")
        }
        if (scaleFit != nil) {
            addQuery(query: "scalefit=\(scaleFit!)")
        }
        if (resizeAlgorithm != nil) {
            addQuery(query: "filter=\(resizeAlgorithm!)")
        }
        if (upscale != nil)  {
            addQuery(query: "upscale=\(upscale!)")
        }
        if (crop != nil){
            addQuery(query: "crop=\(crop!.x),\(crop!.y),\(crop!.w),\(crop!.h)")
        }
        if (edgeCrop != nil) {
            addQuery(query: "ecrop=\(edgeCrop!.left),\(edgeCrop!.top),\(edgeCrop!.right),\(edgeCrop!.bottom)")
            
        }
        
        if (preCrop != nil) {
            addQuery(query: "pcrop=\(preCrop!.x),\(preCrop!.y),\(preCrop!.w),\(preCrop!.h)")
            
        }
        
        if (preEdgeCrop != nil) {
            addQuery(query: "pecrop=\(preEdgeCrop!.left),\(preEdgeCrop!.top),\(preEdgeCrop!.right),\(preEdgeCrop!.bottom)")
        }
        
        
        if (rotateDegrees != nil) {
            if (preRotate == true) {
                addQuery(query: "protate=\(rotateDegrees!)")
            } else {
                addQuery(query: "rotate=\(rotateDegrees!)")
            }
            if (rgb != nil) {
                builder.append(",rgb(\(rgb!.r),\(rgb!.g),\(rgb!.b)")
            }
        }
        
        if (flipH) {
            addQuery(query: "fliph=true")
        }
        if (flipV) {
            addQuery(query: "flipv=true")
        }
        if (format != nil) {
            addQuery(query: "fmt=\(format!)")
        }
        if (formatQuality != nil) {
            addQuery(query: formatQuality!.toString())
        }
        
        if (dpi != nil) {
            addQuery(query: "dpi=\(dpi!)")
            if (dpiFilter != nil) {
                addQuery(query: "dpiFilter=\(dpiFilter!)")
            }
        }
        
        if (strip) {
            addQuery(query: "strip=true")
        }
        
        if (!chromaSubsampling) {
            addQuery(query: "fmt.jpeg.chroma=1,1,1")
        }
        if (colorSpace != nil) {
            addQuery(query: "cs=\(colorSpace!)")
        }
        if (unsharp != nil) {
            addQuery(query: "unsharp=\(unsharp!.radius),\(unsharp!.sigma),\(unsharp!.amount),\(unsharp!.threshold)")
        }
        
        if (compositeMode != nil) {
            addQuery(query: "cm=\(compositeMode!)")
        }
        
        if (backgroundRgb != nil) {
            addQuery(query: "bg=rgb(\(backgroundRgb!.r),\(backgroundRgb!.g),\(backgroundRgb!.b))")
            
        }
        
        if (indexed) {
            addQuery(query: "fmt.png.indexed=true")
            if (paletteSize != nil) {
                addQuery(query: "fmt.png.palettesize=\(paletteSize!)")
            }
        }
        
        if (!dithered) {
            addQuery(query: "fmt.png.dither=false")
        }
        
        if (blur != nil) {
            addQuery(query: "blur=\(blur!.radius),\(blur!.sigma)")
        }
        
        if (reduceNoise != nil) {
            addQuery(query: "noiser=\(reduceNoise!)")
        }
        
        if (gamma != nil) {
            addQuery(query: "gamma=\(gamma!)")
        }
        
        if (hue != nil) { addQuery(query: "hue=\(hue!)")}
        
        if (saturation != nil) { addQuery(query: "sat=\(saturation!)") }
        
        if (brightness != nil) {
            addQuery(query: "bri=\(brightness!)")
        }

        for (i, item) in layers.enumerated() {
            addQuery(query: "layer\(i + 1)=\(item.toQuery())")
        }
        
        return builder
    }
}
