//
//  JobsItemCell.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class JobsItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var appliedIconLabel: UILabel!
    
    var job: Job?
    
    func initCell(job: Job) {
        self.job = job
        titleLabel.text = self.job!.name()
        detailLabel.text = self.job!.getDivision()
        setAppliedStatus()
    }
    
    private func setAppliedStatus() {
        if let id = Context.currentApplicant?.appliedJobId {
            if id == job?.getJobId() {
                IconHelper.setIconForLabel(appliedIconLabel, iconName: .envelope)
            } else {
                IconHelper.setIconForLabel(appliedIconLabel, iconName: .envelopeO)
            }
        }
    }
}
