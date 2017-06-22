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
    
    internal func logout(viewController:UIViewController) {
        NetworkManager.shared.sessionManager.adapter = nil
        KeychainManager().deleteAccessToken()
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginView")
        viewController.present(loginVC, animated: true)
    }

}
