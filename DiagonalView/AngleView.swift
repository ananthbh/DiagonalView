//
//  AngleView.swift
//  DiagonalView
//
//  Created by Ananth Bhamidipati on 13/02/2018.
//  Copyright © 2018 Ananth Bhamidipati. All rights reserved.
//

import UIKit

@IBDesignable class AngleView: UIView {
    
    @IBInspectable var fillColor: UIColor = UIColor.blue { didSet { setNeedsLayout() } }
    
    var points = [
        CGPoint(x: 0.7, y: 0),
        CGPoint(x: 0.3, y: 1),
        CGPoint(x: 1, y: 1),
        CGPoint(x: 1, y: 0)
        ] { didSet { setNeedsLayout() } }
    
    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()
    
    override func layoutSubviews() {
        shapeLayer.fillColor = fillColor.cgColor
        
        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }
        
        let path = UIBezierPath()
        
        path.move(to: convert(relativePoint: points[0]))
        for point in points.dropFirst() {
            path.addLine(to: convert(relativePoint: point))
        }
        path.close()
        
        shapeLayer.path = path.cgPath
    }
    
    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
}
