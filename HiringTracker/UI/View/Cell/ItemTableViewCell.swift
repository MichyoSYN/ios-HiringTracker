//
//  ItemTableViewCell.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

// NO USE
class ItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var thumbnailPhotoImageView: UIImageView!
    
    fileprivate func initCell(_ filename: String, fileType: String) {
        fileNameLabel.text = filename
        if let image = UIImage(named: fileType) {
            thumbnailPhotoImageView.image = image
        } else {
            thumbnailPhotoImageView.image = UIImage(named: "SysObject")
        }
    }
    
//    func getInfoButton() -> UIButton {
//        let buttons = contentView.subviews.filter{ view in
//            return view is UIButton
//        }
//        return buttons[0] as! UIButton
//    }
    
    func initCell(_ object: BasicObject) {
        initCell(object.getName()!, fileType: object.getType()!)
        
//        let infoButton = getInfoButton()
//
//        if object.getType() == RestObjectType.repository.rawValue
//            || object.getLink(LinkRel.objects) != nil {
//            accessoryType = .disclosureIndicator
//            infoButton.isHidden = false
//        } else {
//            accessoryType = .none
//            infoButton.isHidden = true
//        }
    }
    
//    func canGoDeep() {
//        accessoryType = .disclosureIndicator
//        getInfoButton().isHidden = false
//    }
//    
//    func canNotGoDeep() {
//        accessoryType = .none
//        getInfoButton().isHidden = true
//    }
}

