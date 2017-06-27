//
//  SpotifyError.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 25/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation
import Alamofire

struct SpotifyError {
    
    internal let status:Int
    internal let message:String
    
    init(errorJson:[String:Any]) {
        status = errorJson["status"] as! Int
        message = errorJson["message"] as! String
    }
    
    init (status:Int, message:String) {
        self.status = status
        self.message = message
    }
    
}

class ErrorHandler {
    /// Handles errors in Spotify web API call
    /// @return true of false for errors found
    @discardableResult
    internal func handleErrors(response:DataResponse<Any>) -> SpotifyError? {
        
        if let json = response.result.value as? [String:Any] {
            if let errorJson = json["error"] as? [String:Any] {
                let error = SpotifyError(errorJson: errorJson)
                
                print("\(error.status) - \(error.message)")
                
                switch error.status {
                case 401: // The access token expired
                    OAuth().logout()
                    return error
                default:
                    print("Non-handled error")
                }
                
                return error
            }
        }
        
        return nil
    }
}
