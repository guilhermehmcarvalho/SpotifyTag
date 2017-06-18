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
    
    internal func getAlbums(){
        let url = "\(SpotifyBaseEndpoint)v1/me/albums"
        
        NetworkManager.shared.sessionManager.request(url, method: .get).responseString { response in
            //print(response)
        }
        .responseJSON{ response in
            print(response)
        }
            .response{ response in
                //print(response)
        }
    }

}
