//
//  UtilService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/22/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import Foundation
import SwiftyRest

class UtilService {
    
    static func getSingleParamFromResponse(
        url: String,
        key: String,
        thisViewController: UIViewController,
        aiHelper: ActivityIndicatorHelper? = nil,
        completionHandler: @escaping (Any?) -> Void) {
        RestRequest.getRawJson(url: url) { json, error in
            if let error = error {
                failureHandler(error: error, thisViewController: thisViewController, aiHelper: aiHelper)
            } else if let json = json {
                let dictionary = json.object as! NSDictionary
                let result = dictionary.value(forKey: key)
                completionHandler(result)
            }
        }
    }
    
    static func failureHandler(error: RestError, thisViewController: UIViewController, aiHelper: ActivityIndicatorHelper? = nil) {
        ErrorAlert.show(error.getMessage(), controller: thisViewController)
        if let ai = aiHelper {
            ai.stopActivityIndicator()
        }
    }
}
