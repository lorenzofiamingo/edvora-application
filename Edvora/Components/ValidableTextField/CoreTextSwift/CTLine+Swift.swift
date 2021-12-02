import CoreText

extension CTLine {
    
    func glyphRuns() -> [CTRun] {
        CTLineGetGlyphRuns(self) as! [CTRun]
    }
}
