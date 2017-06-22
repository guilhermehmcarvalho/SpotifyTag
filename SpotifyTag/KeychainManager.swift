//
//  KeychainManager.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 22/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation
import Locksmith

class KeychainManager {
    
    private let userAccount = "SpotifyUserAccount"
    
    internal func saveAccessToken(token:String){
        do {
            try Locksmith.updateData(data: ["AccessToken": token], forUserAccount: userAccount)
        }
        catch {
            print("Error saving access token")
        }
    }
    
    internal func getAccessToken() -> String? {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: userAccount)
        
        return dictionary?["AccessToken"] as? String
        
    }
    
    internal func deleteAccessToken() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: userAccount)
        }
        catch {
            print("Error deleting access token")
        }
    }
    
}
