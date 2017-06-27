//
//  SpotifyAPIHandler.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 22/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import Foundation
import Alamofire
import Spotify
import Sync

class SpotifyAPIHandler{
    
    let coreDataHandler:CoreDataHandler
    
    convenience init() {
        let stack = DataStack(modelName: "SpotifyTag")
        self.init(dataStack: stack)
    }
    
    // Dependency injection for testing
    init(dataStack: DataStack) {
        coreDataHandler = CoreDataHandler(dataStack: dataStack)
    }
    
    /// Makes request to spotify Web API, handles errors and gives back response
    internal func apiGetRequest(url:String, completionHandler:@escaping (DataResponse<Any>) -> Void) -> Request {
        return NetworkManager.shared.sessionManager.request(url, method: .get)
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    ErrorHandler().handleErrors(response: response)
                    
                    break
                    
                case .failure(let error):
                        print(error)
                        completionHandler(response)
                    break
                }
                
                completionHandler(response)
        }
    }
    
    @discardableResult
    internal func getMyProfile(completionHandler:@escaping (Profile?) -> ()) -> Request {
        let url = "\(SpotifyBaseEndpoint)v1/me"
        
        return self.apiGetRequest(url: url) { response in
            
            if let responseJSON = response.result.value as? [String:Any] {
                // Save profile in core data
                self.coreDataHandler.saveEntity(json: [responseJSON], name: "Profile") { data in
                    
                    let profile = data?.first as? Profile
                    completionHandler(profile)
                }
            }
            // If it cant get a response, try to get it from core data
            else {
                let profile = self.coreDataHandler.getEntity(entity: "Profile").first as? Profile
                completionHandler(profile)
            }
        }
    }
    
    @discardableResult
    internal func getUsersAlbums(completionHandler:@escaping ([Album]) -> ()) -> Request {
        let url = "\(SpotifyBaseEndpoint)v1/me/albums"
        
        return self.apiGetRequest(url: url) { response in
            let responseJSON = response.result.value as? [String:Any]
            let itemsJSON = responseJSON?["items"] as? [[String:Any]]
            if let albumsJSON = itemsJSON?.map({$0["album"] as! [String:Any]}) {
                
                // Save albums in core data
                self.coreDataHandler.saveEntity(json: albumsJSON, name: "Album") { data in
                    
                    // Convert and return album array to completionHandler
                    if let albums = data as? [Album] {
                        completionHandler(albums)
                    }
                }
            }
        }
    }
    
}
