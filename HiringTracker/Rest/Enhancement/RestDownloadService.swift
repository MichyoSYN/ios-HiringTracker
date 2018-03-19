//
//  RestDownloadService.swift
//  HiringTracker
//
//  Created by Song, Michyo on 3/19/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import UIKit
import SwiftyRest

class RestDownloadService {
    
    static func download(_ contentUrl: String, doAfterDownloaded: @escaping (String) -> Void) -> Void {
        RestRequest.getRestObject(contentUrl) { object, error in
            if let object = object {
                let downloadUrl = object.getLink(.enclosure)
                if let url = downloadUrl {
                    printLog("DownloadUrl for object \(object.getName()!) is \(url)")
                    doAfterDownloaded(url)
                }
            }
        }
    }
}
