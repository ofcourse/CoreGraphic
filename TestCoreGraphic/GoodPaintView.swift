//
//  GoodPaintView.swift
//  TestCoreGraphic
//
//  Created by macbook on 2018/7/19.
//  Copyright © 2018年 HSG. All rights reserved.
//

import UIKit

class GoodPaintView: UIView {

    var tmpImage: UIImage?
    var path: UIBezierPath = UIBezierPath.init()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let content =  UIGraphicsGetCurrentContext()
        content?.setBlendMode(.normal)
        
        if let image  = tmpImage {
            image.draw(at: self.frame.origin)
        }
        path.lineWidth = 10
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        UIColor.red.setStroke()
        path.stroke()
        super.draw(rect)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touchPoint(touches: touches)
        path.move(to: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         let lastEndPoint = path.currentPoint
         let previousPoint  =  touchPrePoint(touches: touches)
         let currentPoint  = touchPoint(touches: touches)
         let midPoint  = middlePoint(p1: previousPoint, p2: currentPoint)
         path.addQuadCurve(to: midPoint, controlPoint: previousPoint)
        
        let minX = min( min((lastEndPoint.x), previousPoint.x),currentPoint.x)
        let minY = min( min((lastEndPoint.y), previousPoint.y),currentPoint.y)
        let maxX = max( max((lastEndPoint.x), previousPoint.x),currentPoint.x)
        let maxY = max( max((lastEndPoint.y), previousPoint.y),currentPoint.y)
        
        let space = (path.lineWidth)*0.5 + 1
        let drawRect = CGRect.init(x: minX-space, y: minY-space, width: maxX-minX+(path.lineWidth), height: maxY-minY+(path.lineWidth))
        setNeedsDisplay(drawRect)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let lastEndPoint = path.currentPoint
        let previousPoint  =  touchPrePoint(touches: touches)
        let currentPoint  = touchPoint(touches: touches)
        //let midPoint  = middlePoint(p1: previousPoint, p2: currentPoint)
        path.addQuadCurve(to: currentPoint, controlPoint: previousPoint)
        
        let minX = min( min((lastEndPoint.x), previousPoint.x),currentPoint.x)
        let minY = min( min((lastEndPoint.y), previousPoint.y),currentPoint.y)
        let maxX = max( max((lastEndPoint.x), previousPoint.x),currentPoint.x)
        let maxY = max( max((lastEndPoint.y), previousPoint.y),currentPoint.y)
        
        let space = (path.lineWidth)*0.5 + 1
        let drawRect = CGRect.init(x: minX-space, y: minY-space, width: maxX-minX+(path.lineWidth)+2, height: maxY-minY+(path.lineWidth)+2)
        setNeedsDisplay(drawRect)
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        tmpImage =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    func touchPoint(touches: Set<UITouch>) -> CGPoint {
        var validTouch: UITouch?
        for touch in touches {
            if (touch.view?.isEqual(self))! {
                validTouch = touch
                break
            }
        }
        guard let th = validTouch  else  {
            return CGPoint.init(x: -1, y: -1)
        }
        return th.location(in: self)
    }
    
    func touchPrePoint(touches: Set<UITouch>) -> CGPoint {
        var validTouch: UITouch?
        for touch in touches {
            if (touch.view?.isEqual(self))! {
                validTouch = touch
                break
            }
        }
        guard let th = validTouch  else  {
            return CGPoint.init(x: -1, y: -1)
        }
        return th.previousLocation(in: self)
    }
    
    func middlePoint(p1:CGPoint, p2:CGPoint) -> CGPoint {
        return CGPoint.init(x: (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5)
    }
    
}
