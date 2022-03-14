//
//  ViewController.swift
//  SquircleDesign
//
//  Created by Xueliang Chen on 2022/3/12.
//

import UIKit
import Squircle

enum GroupCompareType {
    case GroupCompareType_CornerRadius2BezierPath
    case GroupCompareType_CornerRadius2Squircle
    case GroupCompareType_BezierPath2Squircle
}

class ViewController: UIViewController {
        
    private var viewCount:Int = 3
    private var viewCornerRadius:Array = [10, 20, 30]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.buildViews(type: .GroupCompareType_CornerRadius2BezierPath, compare: false)
    }
    
    private func setAsCornerRadius(view: UIView, value: Int) {
        view.backgroundColor = UIColor.red

        view.layer.cornerRadius = CGFloat(value)
        view.layer.masksToBounds = true
    }
    
    private func setAsBezierPath(view: UIView, value: Int) {
        view.backgroundColor = UIColor.blue

        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds;
        
        let newPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: CGFloat(value))
        maskLayer.path = newPath.cgPath
        
        view.layer.mask = maskLayer
    }
    
    private func setAsSquircle(view: UIView, value: Int) {
        view.backgroundColor = UIColor.orange

        view.squircle()
    }
    
    private func buildViews (type: GroupCompareType, compare: Bool) {
        var viewsA: [UIView] = []
        var viewsB: [UIView] = []
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        
        let xPositionA = compare ? screenWidth / 2.0 : screenWidth / 3.0 * 1.0
        let xPositionB = compare ? screenWidth / 2.0 : screenWidth / 3.0 * 2.0
        
        // Left - A
        for i in 0..<viewCount {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            
            view.center.x = xPositionA
            view.center.y = screenHeight / CGFloat(viewCount + 1) * CGFloat(i + 1)
            viewsA.append(view)
            self.view.addSubview(view)
        }
        
        // Right - B
        for i in 0..<viewCount {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            
            view.center.x = xPositionB
            view.center.y = screenHeight / CGFloat(viewCount + 1) * CGFloat(i + 1)
            viewsB.append(view)
            self.view.addSubview(view)
        }
        
        // Apply
        switch type {
        case .GroupCompareType_CornerRadius2BezierPath:
            for i in 0..<self.viewCount {
                self.setAsCornerRadius(view: viewsA[i], value: self.viewCornerRadius[i])
                self.setAsBezierPath(view: viewsB[i], value: self.viewCornerRadius[i])
            }
            break
        case .GroupCompareType_CornerRadius2Squircle:
            for i in 0..<viewCount {
                self.setAsCornerRadius(view: viewsA[i], value: self.viewCornerRadius[i])
                self.setAsSquircle(view: viewsB[i], value: self.viewCornerRadius[i])
            }
            break
        case .GroupCompareType_BezierPath2Squircle:
            for i in 0..<viewCount {
                self.setAsBezierPath(view: viewsA[i], value: self.viewCornerRadius[i])
                self.setAsSquircle(view: viewsB[i], value: self.viewCornerRadius[i])
            }
            break
        default:
            break
        }
    }

}

