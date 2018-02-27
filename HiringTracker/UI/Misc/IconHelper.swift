//
//  IconHelper.swift
//  HiringTracker
//
//  Created by Song, Michyo on 2/27/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import FontAwesome_swift

class IconHelper {
    
    static func setIconForButton(_ button: UIButton, iconName: FontAwesome, size: CGFloat = 25, state: UIControlState = UIControlState()) {
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: size)
        button.setTitle(String.fontAwesomeIcon(name: iconName), for: state)
    }
    
    static func setIconForBarButton(_ button: UIBarButtonItem, iconName: FontAwesome, size: CGFloat = 22, state: UIControlState = UIControlState()) {
        let attributes = [NSAttributedStringKey.font: UIFont.fontAwesome(ofSize: size)] as Dictionary!
        button.setTitleTextAttributes(attributes, for: state)
        button.title = String.fontAwesomeIcon(name: iconName)
    }
    
    static func setIconForLabel(_ label: UILabel, iconName: FontAwesome, size: CGFloat = 25) {
        label.font = UIFont.fontAwesome(ofSize: size)
        label.text = String.fontAwesomeIcon(name: iconName)
    }
    
    static func setIconForImage(
        _ imageView: UIImageView, iconName: FontAwesome,
        width: CGFloat = 25,
        height: CGFloat = 25,
        textColor: UIColor = UIColor.gray,
        backgroundColor: UIColor = UIColor.clear) {
        imageView.image = UIImage.fontAwesomeIcon(name: iconName, textColor: textColor, size: CGSize(width: width, height: height), backgroundColor: backgroundColor)
    }
    
    static func setIconForBarItem(_ barItem: UITabBarItem, iconName: FontAwesome, size: CGFloat = 25) {
        barItem.image = UIImage.fontAwesomeIcon(name: iconName, textColor: UIColor.black, size: CGSize(width: size, height: size), backgroundColor: UIColor.clear)
    }
}
