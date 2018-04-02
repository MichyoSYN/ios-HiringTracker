//
//  ApplicantDetailSectionCell.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/27/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ApplicantDetailSectionCell: UITableViewCell {

    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var sectionNameLabel: UILabel!
    
    static let sectionTitles: [String] = ["Apply Status", "Others"]
    
    func initCell(row: Int) {
        switch row {
        case 0:
            setCell(icon: .info, name: ApplicantDetailSectionCell.sectionTitles[row])
        case 1:
            setCell(icon: .navicon, name: ApplicantDetailSectionCell.sectionTitles[row])
        default:
            return
        }
    }
    
    static func sectionNumber() -> Int {
        return ApplicantDetailSectionCell.sectionTitles.count
    }
    
    private func setCell(icon: FontAwesome, name: String) {
        IconHelper.setIconForLabel(iconLabel, iconName: icon)
        sectionNameLabel.text = name
    }
}
