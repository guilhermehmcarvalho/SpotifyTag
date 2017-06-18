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
        let scope = [SPTAuthStreamingScope, SPTAuthUserReadPrivateScope, SPTAuthUserReadEmailScope, SPTAuthUserLibraryModifyScope]
        
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
    
    /*internal func getAlbums(){
        let url = "\(SpotifyBaseEndpoint)/v1/me/albums"
        
        let token = SPTAuth.defaultInstance().session.accessToken
        sessionManager.adapter = AccessTokenAdapter(accessToken: token!)
        sessionManager.request(url, method: .get).responseString { response in
            print(response)
        }
    }*/

}
