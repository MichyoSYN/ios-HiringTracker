//
//  ErrorAlert.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class ErrorAlert: Alert {
    
    static func show(_ msg: String, controller: UIViewController, dismissViewController: Bool = true) {
        super.show(title: "Error Alert", msg, controller: controller, dismissViewController: dismissViewController)
    }
}
