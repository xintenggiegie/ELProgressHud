//
//  ELProgressHud.swift
//  ELProgressHUD-swift
//
//  Created by 李涌辉 on 16/9/18.
//  Copyright © 2016年 Evil Lee. All rights reserved.
//

import UIKit

private var width : CGFloat = 160
private var height : CGFloat = 120
private let ELProgressHudTag : NSInteger = 962

class ELProgressHud: UIView {
    
    public enum ELProgressHudType : NSInteger {
        case ELProgressHudTypeIndicator = 0// 普通菊花
        case ELProgressHudTypeText
        case ELProgressHudTypeProgress
        case ELProgressHudTypeProgressWithCancel
        case ELProgressHudTypeIndicatorAndText
        case ELProgressHudTypeProgressAndText
        case ELProgressHudTypeGif
        case ELProgressHudTypeDrawCircle
    }
    
    typealias ELCompletion = () -> ()
    var hudType : ELProgressHudType = .ELProgressHudTypeIndicator
    var delay : TimeInterval?
    lazy var textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Loading"
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    var el_progress : Float {
        get {
          return self.el_progress
        }
        set(progress) {
        self.ELProgressView.progress = progress
        }
    }
    
    var elCompletion : ELCompletion?
    var el_images : [String] {
        get {
         return self.el_images
        }
        set(images) {
            var imageArray: [UIImage] = [UIImage].init()
            for imageName: String in images {
                let image: UIImage = UIImage.init(named: imageName)!
                imageArray.append(image)
            }
            self.ELImageView.animationImages = imageArray
            self.ELImageView.startAnimating()
        }
    }
    var el_strokeStart : CGFloat {
        get {
            return self.el_strokeStart
        }
        set(strokeStart) {
           self.ELProgressShapeLayer.strokeStart = strokeStart
        }
    }
    
    
    lazy private var mainView : UIView? = {
        let mainView = UIView()
        mainView.backgroundColor = UIColor.lightGray
        mainView.layer.cornerRadius = 8.0
        mainView.layer.masksToBounds = true
        return mainView
    }()

    lazy private var ELActivityIndicatorView : UIActivityIndicatorView? = {
        let ELActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        return ELActivityIndicatorView
    }()
    
    lazy private var ELProgressView : UIProgressView = {
        let ELProgressView = UIProgressView()
        ELProgressView.progressTintColor = UIColor.orange
        return ELProgressView
    }()
    
    lazy private var ELProgressLabel : UILabel = {
        let ELProgressLabel = UILabel()
        ELProgressLabel.textAlignment = .center
        ELProgressLabel.textColor = UIColor.lightText
        return ELProgressLabel
    }()
    
    lazy private var ELCancelButton : UIButton = {
        let ELCancelButton = UIButton.init(type: .custom)
        ELCancelButton.addTarget(self, action: #selector(ELCancelButtonClick), for: .touchUpInside)
        ELCancelButton.backgroundColor = UIColor.gray
        ELCancelButton.setTitle("Cancel", for: .normal)
        return ELCancelButton
    }()
    
    lazy private var ELImageView : UIImageView = {
        let ELImageView = UIImageView()
        ELImageView.alpha = 0.5
        return ELImageView
    }()
    
    lazy private var ELCircleShapeLayer : CAShapeLayer = {
        let path : UIBezierPath = UIBezierPath.init(ovalIn: CGRect.init(x: width * (1 - 0.6) / 2, y: height * (1 - 0.6) / 2, width: width * 0.6, height: height * 0.6))
        let ELCircleShapeLayer = CAShapeLayer()
        ELCircleShapeLayer.fillColor = UIColor.clear.cgColor
        ELCircleShapeLayer.strokeColor = UIColor.orange.cgColor
        ELCircleShapeLayer.path = path.cgPath
        ELCircleShapeLayer.lineWidth = 3
        return ELCircleShapeLayer
    }()
    
    lazy private var ELProgressShapeLayer : CAShapeLayer = {
        let path : UIBezierPath = UIBezierPath.init(ovalIn: CGRect.init(x: width * (1 - 0.6) / 2, y: height * (1 - 0.6) / 2, width: width * 0.6, height: height * 0.6))
        let ELProgressShapeLayer = CAShapeLayer()
        ELProgressShapeLayer.fillColor = UIColor.clear.cgColor
        ELProgressShapeLayer.strokeColor = UIColor.white.cgColor
        ELProgressShapeLayer.path = path.cgPath
        ELProgressShapeLayer.lineWidth = 3
        return ELProgressShapeLayer
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    required init(hudType: ELProgressHudType) {
        super.init(frame: UIScreen.main.bounds)
        self.hudType = hudType
        setup()
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.hudType = .ELProgressHudTypeIndicator
        setup()
    }
    
    func showHudAtView(aView : UIView) -> Void {
        self.tag = ELProgressHudTag
        self.ELActivityIndicatorView!.startAnimating()
        aView.addSubview(self)
        if self.delay != 0 && self.delay != nil {
            self.perform(#selector(hide), with: nil, afterDelay: self.delay!)
        }
    }
    
    class func showHudAtView(aView : UIView) -> Void {
        let hud : ELProgressHud = ELProgressHud.init(frame: UIScreen.main.bounds)
        hud.tag = ELProgressHudTag
        hud.ELActivityIndicatorView!.startAnimating()
        aView.addSubview(hud)
    }
    
    class func hideHudAtView(aView : UIView) -> Void {
        var hud : ELProgressHud? = aView.viewWithTag(ELProgressHudTag) as? ELProgressHud
        if hud !== nil {
            hud?.mainView = nil
            hud?.ELActivityIndicatorView = nil
            width = 160
            height = 120
            hud?.removeFromSuperview()
            hud = nil
        }
    }
    
    private func setup() {
      self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.mainView?.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        self.mainView?.center = CGPoint.init(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 20)
        self.addSubview(self.mainView!)
        switch self.hudType {
        case .ELProgressHudTypeIndicator:
                width = 80
                height = 80
                self.ELActivityIndicatorView?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
                self.ELActivityIndicatorView?.center = CGPoint.init(x: width / 2, y: height / 2)
                self.mainView?.addSubview(self.ELActivityIndicatorView!)
            
        case .ELProgressHudTypeText:
            height = 60
            self.textLabel.frame = CGRect.init(x: 0, y: 0, width: width, height: 44)
            self.textLabel.center = CGPoint.init(x: width / 2, y: height / 2)
            self.mainView?.addSubview(self.textLabel)
            
        case .ELProgressHudTypeProgress:
            height = 80
            setupELProgressLabel()
            setupELProgressView()
            self.mainView?.addSubview(self.ELProgressLabel)
            self.mainView?.addSubview(self.ELProgressView)
            
        case .ELProgressHudTypeProgressWithCancel:
            setupELProgressLabel()
            setupELProgressView()
            self.ELCancelButton.frame = CGRect.init(x: 0, y: 0, width: width * 0.4, height: 36)
            self.ELCancelButton.center = CGPoint.init(x: width / 2, y: height * 0.8)
            self.mainView?.addSubview(self.ELProgressLabel)
            self.mainView?.addSubview(self.ELProgressView)
            self.mainView?.addSubview(self.ELCancelButton)
            
        case .ELProgressHudTypeIndicatorAndText:
            setupELActivityIndicatorView()
            setupTextLabel()
            self.mainView?.addSubview(self.ELActivityIndicatorView!)
            self.mainView?.addSubview(self.textLabel)
            
        case .ELProgressHudTypeProgressAndText:
            setupELProgressLabel()
            setupELProgressView()
            setupTextLabel()
            self.mainView?.addSubview(self.ELProgressLabel)
            self.mainView?.addSubview(self.ELProgressView)
            self.mainView?.addSubview(self.textLabel)
            
        case .ELProgressHudTypeGif:
            self.ELImageView.frame = (self.mainView?.bounds)!
            self.mainView?.addSubview(self.ELImageView)
            
        case .ELProgressHudTypeDrawCircle:
            width = 120
            self.ELProgressShapeLayer.frame = (self.mainView?.bounds)!
            self.ELCircleShapeLayer.frame = (self.mainView?.bounds)!
            self.mainView?.layer.addSublayer(self.ELCircleShapeLayer)
            self.mainView?.layer.addSublayer(self.ELProgressShapeLayer)
            self.ELProgressLabel.frame = CGRect.init(x: 0, y: 0, width: width * 0.5, height: 30)
            self.ELProgressLabel.center = CGPoint.init(x: width / 2, y: height / 2)
            self.mainView?.addSubview(self.ELProgressLabel)
            
        }
    }
    
    override func layoutSubviews() {
        self.mainView?.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        self.mainView?.center = CGPoint.init(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 20)
    }
    
    private func setupELActivityIndicatorView() {
        self.ELActivityIndicatorView?.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        self.ELActivityIndicatorView?.center = CGPoint.init(x: width / 2, y: 50)
    }
    
    private func setupELProgressLabel() {
        self.ELProgressLabel.frame = CGRect.init(x: 0, y: 0, width: width / 2, height: 30)
        self.ELProgressLabel.center = CGPoint.init(x: width / 2, y: height * 0.2)
    }
    
    private func setupELProgressView() {
        self.ELProgressView.frame = CGRect.init(x: 0, y: 0, width: width * 0.8, height: 1)
        self.ELProgressView.center = CGPoint.init(x: width / 2, y: height / 2)
        //self.ELProgressView.transform = cgaffinetransform
    }
    
    private func setupTextLabel() {
        self.textLabel.frame = CGRect.init(x: 0, y: 0, width: width, height: 44)
        self.textLabel.center = CGPoint.init(x: width / 2, y: height - 30)
    }
    
    @objc private func hide() {
        self.mainView = nil
        self.ELActivityIndicatorView = nil
        width = 160
        height = 120
        self.removeFromSuperview()
    }
    
    @objc private func ELCancelButtonClick() {
        if self.elCompletion != nil {
            self.elCompletion!()
        }
        self.elCompletion = nil
        self.hide()
    }
    
}
