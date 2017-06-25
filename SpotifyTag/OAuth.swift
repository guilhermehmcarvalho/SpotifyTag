//
//  OAuth.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 18/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation
import Spotify

class OAuth {
    
    var auth = SPTAuth.defaultInstance()!
    
    internal func authorize(){
        let scope = [SPTAuthUserLibraryReadScope]
        
        SPTAuth.defaultInstance().clientID = ClientID
        SPTAuth.defaultInstance().redirectURL = URL(string: Config().redirectURI)
        SPTAuth.defaultInstance().requestedScopes = scope
        if let loginURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL() {
            if UIApplication.shared.openURL(loginURL) {
                if auth.canHandle(auth.redirectURL) {
                    // To do - build in error handling
                    
                }
            }
        }
    }
    
    /// Saves access token to keychain and to network manager session
    internal func handleAccessToken(token:String){
        NetworkManager.shared.sessionManager.adapter = AccessTokenAdapter(accessToken: token)
        KeychainManager().saveAccessToken(token: token)
    }
    
    internal func logout() {
        NetworkManager.shared.sessionManager.adapter = nil
        KeychainManager().deleteAccessToken()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goToMainView()
    }

}
