//
//  Alert.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/21/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit

class Alert {
    static func show(title: String = "Alert", _ msg: String, controller: UIViewController, dismissViewController: Bool = true) {
        let alertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(
            title: "Dismiss",
            style: .default) { UIAlertAction in
                if dismissViewController {
                    dismissThisViewController(controller)
                }
            }
        )
        controller.present(alertController, animated: true, completion: nil)
    }
    
    internal static func dismissThisViewController(_ controller: UIViewController) {
        var navi: UINavigationController = controller.navigationController!
        if navi.viewControllers.count == 1 {
            if navi.navigationController != nil {
                navi = navi.navigationController!
            }
        }
        navi.setNavigationBarHidden(false, animated: true)
        navi.popViewController(animated: true)
    }
}
