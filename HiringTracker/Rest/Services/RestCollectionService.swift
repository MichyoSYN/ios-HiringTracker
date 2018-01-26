//
//  RestCollectionService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/26/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class RestCollectionService {
    
    // Must be defined in subClass
    var url: String!
    
    init() {
        
    }
    
    init(url: String) {
        self.url = url
    }
    
    init(tail: String) {
        self.url = Context.contextUrl() + tail
    } // TODO: may delete after complete
    
    func setUrl(_ url: String) {
        self.url = url
    }
    
    internal func getParams(_ pageNo: NSInteger) -> [String: String] {
        var params = UriBuilder.pageParam(pageNo)
        let inlineParam = UriBuilder.inlineParam()
        for param in inlineParam {
            params[param.0] = param.1
        }
        return params
    }
    
    fileprivate func getLatestUrl() {
        url = Context.contextUrl()
    }
    
    func getService(_ pageNo: NSInteger, completionHandler: @escaping (Array<RestObject>?, RestError?) -> ()) {
//        getLatestUrl()
    }
    
    func getEntries(
        _ pageNo: NSInteger,
        thisViewController: AbstractCollectionViewController,
        completionHandler: @escaping ([BasicObject], Bool) -> ()) {
        self.getService(pageNo) { entries, error in
            if let error = error {
                let errorMsg = error.getMessage()
                ErrorAlert.show(errorMsg, controller: thisViewController)
                thisViewController.aiHelper.stopActivityIndicator()
                return
            } else {
                var restObjects: [BasicObject] = []
                var isLastPage = true
                if let entries = entries {
                    for entry in entries {
                        restObjects.append(self.constructRestObject(entry))
                    }
                    isLastPage = entries.count < ServiceConstants.getItemsPerPage()
                }
                completionHandler(restObjects, isLastPage)
            }
        }
    }
    
    // Should be overwrite to construct different kind of rest objects
    func constructRestObject(_ object: RestObject) -> BasicObject {
        return BasicObject(object: object)
    }
}

