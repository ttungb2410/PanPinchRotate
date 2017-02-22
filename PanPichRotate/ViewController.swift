//
//  ViewController.swift
//  PanPichRotate
//
//  Created by TTung on 2/21/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate{

    var fire = UIImageView()
    var water = UIImageView()
    var radians = CGFloat()
    var radians2 = CGFloat()
    var fireRadius:CGFloat = 40
    var mainViewSize = CGSize()
    var direction:CGFloat = 1
    var deltaAngle: CGFloat = 0.1
    var right:Bool = true
    var timeFire:Timer!
    var timeWater:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFire()
        addWater()
        timeFire = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(rollFire), userInfo: nil, repeats: true)
        timeWater = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(waterRoll), userInfo: nil, repeats: true)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        fire.isUserInteractionEnabled = true
        fire.addGestureRecognizer(panGesture)
        water.isUserInteractionEnabled = true
        water.addGestureRecognizer(panGesture)
    }
    
    func addFire(){
        mainViewSize = self.view.bounds.size
        fire = UIImageView(image: UIImage(named: "fire.png"))
        fire.center = CGPoint(x: fireRadius, y: mainViewSize.height*0.5)
        self.view.addSubview(fire)
    }
    func addWater()  {
        
        water = UIImageView(image: UIImage(named: "water.png"))
        water.center = CGPoint(x: mainViewSize.width*0.5, y: mainViewSize.height*0.5)
        self.view.addSubview(water)
    }
    func waterRoll(){
        let deltaAngleWater:CGFloat = 0.1
         radians2 = radians2 + deltaAngleWater
        let rotate = CGAffineTransform(rotationAngle: radians2)
        water.transform = rotate
    }
    
    func onPan(panGesture: UIPanGestureRecognizer){
        if (panGesture.state == .began || panGesture.state == .changed ){
            let point = panGesture.location(in: self.view)
            self.fire.center = point
            self.water.center = point
    }
    }
    
    
    func rollFire(){
        if right == true{
            changeDirextion()
            rollLeftToRight()
        }else{
            changeDirextion()
            rollRightToLeft()
        }
    }
    
    func rollLeftToRight(){
        deltaAngle = 0.1
        radians = radians + deltaAngle
        let rotate = CGAffineTransform(rotationAngle: radians)
        fire.transform = rotate
        
        self.fire.center = CGPoint(x: self.fire.center.x + fireRadius*deltaAngle , y: self.fire.center.y + fireRadius*deltaAngle*direction)
        
        if fire.center.x > mainViewSize.width - fireRadius{
            deltaAngle = -0.1
             right = false
        }
    }
    
    func rollRightToLeft(){
        deltaAngle = -0.1
         radians = radians + deltaAngle
        let rotate = CGAffineTransform(rotationAngle: radians)
        fire.transform = rotate
        
        self.fire.center = CGPoint(x: self.fire.center.x + fireRadius*deltaAngle, y: self.fire.center.y - fireRadius*deltaAngle*direction)
        
        if fire.center.x < fireRadius {
            deltaAngle = 0.1
             right = true
        }
    }
    
    func changeDirextion(){
            let dic = randomDirection()
        if fire.center.y < fireRadius {
            direction = dic
        }
        else if fire.center.y > mainViewSize.height - fireRadius{
            direction = -dic
        }
    }
    
    func randomDirection() -> CGFloat{
        return CGFloat(Float(arc4random())/Float(UINT32_MAX))
    }


}

