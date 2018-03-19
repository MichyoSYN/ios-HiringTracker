//
//  RestSingleService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class RestSingleService {
    var url: String!
    
    init(url: String) {
        self.url = url
    }
    
    func getObject(
        thisViewController: UIViewController,
        aiHelper: ActivityIndicatorHelper,
        params: [String : Any]? = nil,
        completionHandler: @escaping (BasicObject) -> ()) {
        RestRequest.getRestObject(url, params: params) { object, error in
            if let error = error {
                let errorMsg = error.getMessage()
                ErrorAlert.show(errorMsg, controller: thisViewController)
                aiHelper.stopActivityIndicator()
                return
            } else if let restObject = object {
                completionHandler(BasicObject(object: restObject))
            }
        }
    }
}
