//
//  Context.swift
//  HiringTracker
//
//  Created by Song, Michyo on 1/25/18.
//  Copyright © 2018 Song, Michyo. All rights reserved.
//

import Foundation

class Context {
    // MARK: Rest Info
    static var rootUrl: String = "http://localhost:8080"
    static var appContext: String = "/dctm-rest"
    
    static func contextUrl() -> String {
        return rootUrl + appContext
    }
    
    // MARK: User Info
    static var currentUser: User?
}
