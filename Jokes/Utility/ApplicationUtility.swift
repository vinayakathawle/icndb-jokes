//
//  ApplicationUtility.swift
//  Jokes
//
//  Created by Vinayak Kakade on 5/6/18.
//  Copyright © 2018 Vinayak Kakade. All rights reserved.
//

import UIKit

extension UIButton {
    func shapeButton() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.cornerRadius = 20.0
    }
}

extension UITextField {
    func shapeTextField() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.5
        self.layer.cornerRadius = 1.0
        self.textAlignment = .center
        
    }
}

extension UIView {
    func shapeView() {
        // creating shadow for view
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        // creating corner radius and border color
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func makeCircular() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}

extension UICollectionViewCell {
    func shapeCellView() {
        // creating shadow for view
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        // creating corner radius and border color
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.black.cgColor
    }
}

extension UILabel {
    func applyAmbossEffect() {
        // creating shadow for number lable for amboss effect
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}

class ApplicationUtility: NSObject {
    
    /**
     This will show toast message on given view.
     
     - parameter message: The message for toast.
     - parameter view:    The view on which toast needs to show.
     - parameter margin:  The margin needs to add while showing the message.
     */

    class func showToast(message : String) {
        let window :UIWindow = UIApplication.shared.keyWindow!

        let toastLabel = UITextView(frame: CGRect(x: window.frame.size.width/16, y: window.frame.size.height-100, width: window.frame.size.width * 7/8, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = "   \(message)   "
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.font = UIFont(name: (toastLabel.font?.fontName)!, size: 16)
        toastLabel.layoutMargins.left = 8
        toastLabel.layoutMargins.right = 8
        toastLabel.center.x = window.frame.size.width/2
        window.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}


