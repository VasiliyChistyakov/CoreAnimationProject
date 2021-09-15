//
//  SecondViewController.swift
//  CALayer test
//
//  Created by Чистяков Василий Александрович on 19.08.2021.
//

import UIKit

class SecondViewController: UIViewController, CAAnimationDelegate{
    
    var shapeLayerSV: CAShapeLayer!{
        didSet{
            shapeLayerSV.lineWidth = 20
            shapeLayerSV.lineCap = CAShapeLayerLineCap.round
            shapeLayerSV.fillColor = nil
            shapeLayerSV.strokeEnd = 1
            let color = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor
            shapeLayerSV.strokeColor = color
        }
    }
    
    var overShapeLayerSV: CAShapeLayer!{
        didSet{
            overShapeLayerSV.lineWidth = 20
            overShapeLayerSV.lineCap = CAShapeLayerLineCap.round
            overShapeLayerSV.fillColor = nil
            overShapeLayerSV.strokeEnd = 0
            let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            overShapeLayerSV.strokeColor = color
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
        }
    }
    
    @IBOutlet weak var iamgeSVC: UIImageView! {
        didSet {
            iamgeSVC.layer.cornerRadius = iamgeSVC.layer.frame.size.height / 2
            iamgeSVC.layer.masksToBounds = true
            let borderColor = UIColor.white.cgColor
            iamgeSVC.layer.borderColor = borderColor
            iamgeSVC.layer.borderWidth = 5
        }
    }
    
    @IBOutlet weak var takeButton: UIButton! {
        didSet {
            takeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            takeButton.layer.shadowOpacity = 0.5
            takeButton.layer.shadowRadius = 5
        }
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer ){
        shapeLayer.frame = view.bounds
        let path = UIBezierPath(arcCenter: view.center, radius: 150, startAngle: -( .pi / 2), endAngle: .pi * 2, clockwise: true)
        // let cirlcePath = UIBezierPath(arcCenter: view.center, radius: 150, startAngle: -(.pi / 2), endAngle: .pi * 2, clockwise: true)
        //        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2))
        //        path.addLine(to: CGPoint (x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
        shapeLayer.path = path.cgPath
    }
    
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayerSV = CAShapeLayer()
        view.layer.addSublayer(shapeLayerSV)
        
        overShapeLayerSV = CAShapeLayer()
        view.layer.addSublayer(overShapeLayerSV)
        
        configShapeLayer(shapeLayerSV)
        configShapeLayer(overShapeLayerSV)
    }
    
    @IBAction func takeAction(_ sender: Any) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut  )
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        animation.delegate = self
        
        overShapeLayerSV.add(animation, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("win")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
