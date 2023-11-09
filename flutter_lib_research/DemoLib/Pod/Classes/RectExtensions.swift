//
//  RectExtensions.swift
//  NTUIKit
//
//  Created by HarrisonFu on 2022/6/18.
//

import Foundation


public extension CGRect {
    
    static func copy(frame:CGRect,
                     x:CGFloat? = nil,
                     y:CGFloat? = nil,
                     w:CGFloat? = nil,
                     h:CGFloat? = nil) -> CGRect {
        let iX = ((x != nil) ? x : frame.minX) ?? 0.0
        let iY = ((y != nil) ? y : frame.minY) ?? 0.0
        let iW = ((w != nil) ? w : frame.size.width) ?? 0.0
        let iH = ((h != nil) ? h : frame.size.height) ?? 0.0
        let rect = CGRect(x: iX, y: iY, width: iW, height: iH)
        return rect
    }
    
    static func copyFrom(frame:CGRect,
                     x:CGFloat? = nil,
                     y:CGFloat? = nil,
                     w:CGFloat? = nil,
                     h:CGFloat? = nil,
                     isRTL: Bool = false) -> CGRect {
        var rect = frame
        if isRTL {
            var iX:CGFloat = 0
            if let w = w {
                iX = frame.maxX - w
            } else {
                iX = ((x != nil) ? x : frame.minX) ?? 0.0
            }
            let iY = ((y != nil) ? y : frame.minY) ?? 0.0
            let iW = ((w != nil) ? w : frame.size.width) ?? 0.0
            let iH = ((h != nil) ? h : frame.size.height) ?? 0.0
            rect = CGRect(x: iX, y: iY, width: iW, height: iH)
        } else {
            let iX = ((x != nil) ? x : frame.minX) ?? 0.0
            let iY = ((y != nil) ? y : frame.minY) ?? 0.0
            let iW = ((w != nil) ? w : frame.size.width) ?? 0.0
            let iH = ((h != nil) ? h : frame.size.height) ?? 0.0
            rect = CGRect(x: iX, y: iY, width: iW, height: iH)
        }
        return rect
    }
    
    
    
    
    
    static func copyCenter(frame:CGRect,
                           w:CGFloat? = nil,
                           h:CGFloat? = nil) -> CGRect {
        let iW = ((w != nil) ? w : frame.size.width) ?? 0.0
        let iH = ((h != nil) ? h : frame.size.height) ?? 0.0
        let iX = frame.minX + frame.width/2.0 - iW/2.0
        let iY = frame.minY + frame.height/2.0 - iH/2.0
        let rect = CGRect(x: iX, y: iY, width: iW, height: iH)
        return rect
    }
    
    static func centerOf(frame: CGRect) -> CGPoint {
        return CGPoint(x: frame.width/2.0, y: frame.height/2.0)
    }
    
}
