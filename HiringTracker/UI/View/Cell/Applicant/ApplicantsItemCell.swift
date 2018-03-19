//
//  ApplicantsItemCell.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class ApplicantsItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var applicant: Applicant?

    func initCell(applicant: Applicant) {
        self.applicant = applicant
        titleLabel.text = self.applicant!.name()
    }
}
