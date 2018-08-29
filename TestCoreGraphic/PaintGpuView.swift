//
//  PaintGpuView.swift
//  TestCoreGraphic
//
//  Created by macbook on 2018/8/29.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit

class PaintGpuView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var line: UIBezierPath = UIBezierPath.init()
    var slayer: CAShapeLayer!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            line.lineWidth = 10
            line.lineCapStyle = .round
            line.lineJoinStyle = .round
            line.move(to: firstTouch.location(in: firstTouch.view))
            
            slayer = CAShapeLayer.init()
            slayer.path = line.cgPath
            slayer.backgroundColor = UIColor.clear.cgColor
            slayer.fillColor  = UIColor.clear.cgColor
            slayer.lineCap = "round"
            slayer.lineJoin = "round"
            slayer.strokeColor = UIColor.red.cgColor
            slayer.lineWidth = line.lineWidth
            self.layer.addSublayer(slayer)

        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch  = touches.first {
            line.addLine(to: firstTouch.location(in: firstTouch.view))
            slayer.path = line.cgPath
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }

}
