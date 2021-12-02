import CoreText

extension CTFont {
    
    func xHeight() -> CGFloat {
        CTFontGetXHeight(self)
    }
    
    func advances(of glyphs: [CGGlyph], orientation: CTFontOrientation = .default) -> [CGSize] {
        [CGSize](unsafeUninitializedCapacity: glyphs.count) { (bufferPointer, count) in
            CTFontGetAdvancesForGlyphs(self, orientation, glyphs, bufferPointer.baseAddress!, glyphs.count)
            count = glyphs.count
        }
    }
    
    func path(for glyph: CGGlyph, transform: CGAffineTransform = .identity) -> CGPath? {
        var transform = transform
        return CTFontCreatePathForGlyph(self, glyph, &transform)
    }
}
