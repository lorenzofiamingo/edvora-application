import CoreText

extension CTRun {
    
    func glyphs() -> [CGGlyph] {
        let runGlyphsCount = CTRunGetGlyphCount(self)
        return [CGGlyph](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
            CTRunGetGlyphs(self, CFRange(), bufferPointer.baseAddress!)
            count = runGlyphsCount
        }
    }
    
    func glyphsAdvances() -> [CGSize] {
        font.advances(of: glyphs())
    }
    
    func glyphPositions() -> [CGPoint] {
        let runGlyphsCount = CTRunGetGlyphCount(self)
        return [CGPoint](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
            CTRunGetPositions(self, CFRange(), bufferPointer.baseAddress!)
            count = runGlyphsCount
        }
    }
    
    var font: CTFont {
        let attributes = CTRunGetAttributes(self) as! [String: Any]
        return attributes[kCTFontAttributeName as String] as! CTFont
    }
}
