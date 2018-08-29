//
//  PaintView.swift
//  TestCoreGraphic
//
//  Created by macbook on 2018/7/18.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit

class PaintView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var lines: [UIBezierPath] = []

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing cod

        for line in lines {
            line.lineWidth = 10
            line.lineCapStyle = .round
            line.lineJoinStyle = .round
            
            UIColor.red.setStroke()
            line.stroke()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let line = UIBezierPath.init()
            line.move(to: firstTouch.location(in: firstTouch.view))
            lines.append(line)
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let line = lines.last,let firstTouch  = touches.first {
            line.addLine(to: firstTouch.location(in: firstTouch.view))
            setNeedsDisplay()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         touchesMoved(touches, with: event)
    }
}
