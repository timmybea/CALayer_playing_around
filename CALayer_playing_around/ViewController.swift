//
//  ViewController.swift
//  CALayer_playing_around
//
//  Created by Tim Beals on 2017-03-04.
//  Copyright © 2017 Tim Beals. All rights reserved.
//
// following along with tutorial: https://www.raywenderlich.com/90488/calayer-in-ios-with-swift-10-examples


import UIKit

class ViewController: UIViewController {

    
    let playView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        view.backgroundColor = UIColor.red
        return view
    }()
    
    var playLayer: CALayer {
        return playView.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayView()
        setupPlayLayer()
        setupGestureRcognizers()
    }
    
    private func setupPlayLayer() {
        
        playLayer.backgroundColor = UIColor.red.cgColor
        playLayer.borderWidth = 30.0
        playLayer.borderColor = UIColor.darkGray.cgColor
        playLayer.shadowOpacity = 0.4
        playLayer.shadowRadius = 10.0
        playLayer.shadowOffset = CGSize(width: 16.0, height: 4.0)
        playLayer.contents = UIImage(named: "asset")?.cgImage
        playLayer.contentsGravity = kCAGravityCenter
    }

    private func setupPlayView() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(playView)
        playView.center = view.center
    }
    
    private func setupGestureRcognizers() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(tapRecognizer:)))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 2
        playView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(pinchRecognizer:)))
        playView.addGestureRecognizer(pinchGesture)
    }

    func handleTap(tapRecognizer: UITapGestureRecognizer) {
        
        playLayer.shadowOpacity = playLayer.shadowOpacity == 0.4 ? 0.0 : 0.4
        
    }
    
    
    func handlePinch(pinchRecognizer: UIPinchGestureRecognizer) {
        //if the pinch is going inwards the pinch scale is always less than one. If the pinch is going outwards then it is always greater than one.
        
        let offset: CGFloat = pinchRecognizer.scale < 1 ? 5.0 : -5.0
        
        let oldFrame = playLayer.frame
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPoint(x: oldOrigin.x + offset, y: oldOrigin.y + offset)
        let newSize = CGSize(width: oldFrame.width + (offset * -2), height: oldFrame.height + (offset * -2))
        let newFrame = CGRect(origin: newOrigin, size: newSize)
        
        if newFrame.width >= 100 && newFrame.width <= 300 {
            playLayer.borderWidth -= offset / 3
            playLayer.cornerRadius += (offset / 2)
            playLayer.frame = newFrame
        }
    }
}

