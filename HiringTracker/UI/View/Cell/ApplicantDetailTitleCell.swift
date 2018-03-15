//
//  ApplicantDetailTitleCell.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class ApplicantDetailTitleCell: UITableViewCell {
    
    @IBOutlet weak var applicantAvatar: UIImageView!
    @IBOutlet weak var applicantName: UILabel!
    @IBOutlet weak var applicantLastJob: UILabel!
    
    var applicant: Applicant?
    
    func initCell(applicant: Applicant) {
        self.applicant = applicant
        
        IconHelper.setIconForImage(applicantAvatar, iconName: .userO)
        applicantName.text = self.applicant!.name()
        applicantLastJob.text = self.applicant!.loginId// TODO: change to status
    }
    
}
