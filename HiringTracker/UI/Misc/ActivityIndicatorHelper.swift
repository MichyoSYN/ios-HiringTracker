//
//  ActivityIndicatorHelper.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/25/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class ActivityIndicatorHelper {
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 10000, height: 10000))
    
    func addActivityIndicator(_ parentView: UIView) {
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = parentView.center
        activityIndicator.hidesWhenStopped = true
        parentView.addSubview(activityIndicator)
    }
    
    // MARK: - Activity indicator handling
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = UIColor.clear
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
}

