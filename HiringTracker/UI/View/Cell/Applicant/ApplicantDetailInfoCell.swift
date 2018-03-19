//
//  ApplicantDetailInfoCell.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class ApplicantDetailInfoCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let showKeys: [String] = ["Contact", "Title", "Location", "Speciality"]
    static let keys: [ApplicantProperties] = [.contactNumber, .applyJobTitle, .location, .speciality]
    
    func initCell(applicant: Applicant, indexPath: IndexPath) {
        let properties = applicant.getProperties()
        let i = indexPath.row
        keyLabel.text = ApplicantDetailInfoCell.showKeys[i]

        let value = properties.value(forKey: ApplicantDetailInfoCell.keys[i].rawValue)
        
        if nil == value || value is NSNull || (String(describing: value!).isEmpty) {
            setHintForLabel(label: valueLabel)
        } else {
            valueLabel.text = String(describing: value!)
        }
    }
    
    private func setHintForLabel(label: UILabel) {
        let attrs: [NSAttributedStringKey: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.italicSystemFont(ofSize: 15)
        ]
        valueLabel.attributedText = NSAttributedString(string: "Empty Here", attributes: attrs)
    }
}
