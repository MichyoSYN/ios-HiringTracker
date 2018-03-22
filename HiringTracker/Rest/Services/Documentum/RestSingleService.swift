//
//  RestSingleService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/1/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest
import Alamofire

class RestSingleService: UtilService {
    var url: String!
    
    init(url: String) {
        self.url = url
    }
    
    private func getParams(params: [String: Any]?) -> [String: Any] {
        var requestParams = ["view": ":all"] as [String: Any]
        if  let p = params {
            for each in p {
                requestParams[each.key] = each.value
            }
        }
        return requestParams
    }
    
    func getObject(
        thisViewController: UIViewController,
        aiHelper: ActivityIndicatorHelper? = nil,
        params: [String : Any]? = nil,
        completionHandler: @escaping (BasicObject) -> ()) {
        RestRequest.getRestObject(url, params: getParams(params: params)) { object, error in
            if let error = error {
                UtilService.failureHandler(error: error, thisViewController: thisViewController, aiHelper: aiHelper)
                return
            } else if let restObject = object {
                completionHandler(BasicObject(object: restObject))
            }
        }
    }
    
    func putObject(
        thisViewController: UIViewController,
        aiHelper: ActivityIndicatorHelper? = nil,
        params: [String: Any]? = nil,
        completionHandler: @escaping (BasicObject) -> ()) {
        RestRequest.getRawJson(.PUT, url: url, params: params, headers: getPostRequestHeaders(), encoding: URLEncoding.queryString) { json, error in
            if let error = error {
                UtilService.failureHandler(error: error, thisViewController: thisViewController, aiHelper: aiHelper)
                return
            } else if let json = json {
                let dictionary = json.object as! NSDictionary
                let object = RestObject(entry: dictionary)
                completionHandler(BasicObject(object: object))
            }
        }
    }
    
    private func getPostRequestHeaders() -> [String: String] {
        var headers = AuthManager.getAuthHeader()
        headers["Content-Type"] = ServiceConstants.MIME_JSON
        return headers
    }
}
