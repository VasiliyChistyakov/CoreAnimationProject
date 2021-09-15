//
//  ViewController.swift
//  CALayer test
//
//  Created by Чистяков Василий Александрович on 19.08.2021.
//
import Foundation
import UIKit

class ViewController: UIViewController, CAAnimationDelegate  {
    
    var shapeLayer: CAShapeLayer!{
        didSet{
            shapeLayer.lineWidth = 20
            shapeLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor
            shapeLayer.strokeColor = color
            
        }
    }
    
    var overShapeLayer: CAShapeLayer!{
        didSet{
            overShapeLayer.lineWidth = 20
            overShapeLayer.lineCap = CAShapeLayerLineCap.round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
            let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            overShapeLayer.strokeColor = color
            
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColour = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            let endColour = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            gradientLayer.colors = [startColour, endColour]
            
        }
    }
    
    @IBOutlet weak var imageVC: UIImageView! {
        didSet {
            imageVC.layer.cornerRadius = imageVC.frame.size.height / 2
            imageVC.layer.masksToBounds = true
            let borderColour = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            imageVC.layer.backgroundColor = borderColour
            imageVC.layer.borderWidth = 5
        }
    }
    
    @IBOutlet weak var tapButton: UIButton! {
        didSet {
            tapButton.layer.shadowOffset = CGSize(width: 0, height: 5)
            tapButton.layer.shadowOpacity = 0.5
            tapButton.layer.shadowRadius = 5
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer ){
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2))
        path.addLine(to: CGPoint (x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
        shapeLayer.path = path.cgPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer )
    }
    @IBAction func tapped(_ sender: UIButton) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut  )
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        animation.delegate = self
        
        overShapeLayer.add(animation, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performSegue(withIdentifier: "showSecondScreen", sender: self)
    }
}

