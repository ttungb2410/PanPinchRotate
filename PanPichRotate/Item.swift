//
//  Item.swift
//  PanPichRotate
//
//  Created by TTung on 2/21/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class Item: UIImageView, UIGestureRecognizerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup(){
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        self.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchPhoto))
        self.addGestureRecognizer(pinchGesture)
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotatePhoto))
        rotateGesture.delegate = self
        self.addGestureRecognizer(rotateGesture)
    }
    
    func onPan(panGesture: UIPanGestureRecognizer)  {
        if (panGesture.state == .began || panGesture.state == .changed){
            let point = panGesture.location(in: self.superview)
            self.center = point
        }
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func pinchPhoto(pinchGestureRecognizer: UIPinchGestureRecognizer)  {
        if let view = pinchGestureRecognizer.view
        {
            view.transform = view.transform.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale)
            pinchGestureRecognizer.scale = 1
        }
    }
    
    func rotatePhoto(rotateGestureRecognizer: UIRotationGestureRecognizer)  {
        if let view = rotateGestureRecognizer.view {
            view.transform = view.transform.rotated(by: rotateGestureRecognizer.rotation)
                rotateGestureRecognizer.rotation = 0
            
        }
    }
}

