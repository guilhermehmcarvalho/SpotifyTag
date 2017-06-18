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
    
    
    public func request(url:String, completionHandler:() -> ()) {
        Alamofire.request(SpotifyBaseEndpoint).responseJSON { response in
        }
    }
}
