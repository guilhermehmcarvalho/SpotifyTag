//
//  NetworkManager.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 18/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    internal let sessionManager:SessionManager
    static let shared = NetworkManager()
    
    private init(){
        self.sessionManager = SessionManager()
    }
    
    
}
