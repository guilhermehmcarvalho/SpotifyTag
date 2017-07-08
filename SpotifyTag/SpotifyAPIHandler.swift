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
    let baseEndpoint:String
    
    convenience init() {
        let stack = DataStack(modelName: "SpotifyTag")
        self.init(dataStack: stack, baseEndpoint: Config().SpotifyBaseEndpoint)
    }
    
    // Dependency injection for testing
    init(dataStack: DataStack, baseEndpoint:String) {
        coreDataHandler = CoreDataHandler(dataStack: dataStack)
        self.baseEndpoint = baseEndpoint
    }
    
    /// Makes request to spotify Web API, handles errors and gives back response
    internal func apiRequest(params:[String:Any]? = [:],
                             method:HTTPMethod,
                             paramEncoding:ParameterEncoding = URLEncoding.default,
                             url:String,
                             headers:HTTPHeaders? = nil,
                             completionHandler:@escaping (DataResponse<Any>,SpotifyError?) -> Void) -> Request {
        
        return NetworkManager.shared.sessionManager.request(url, method: method, parameters: params, encoding: paramEncoding, headers: headers)
            .responseJSON { response in
                
                var sptError:SpotifyError? = nil
                
                switch response.result {
                case .success:
                    sptError = ErrorHandler().handleErrors(response: response)
                    
                    break
                    
                case .failure(let error):
                        print(error)
                    break
                }
                
                completionHandler(response, sptError)
        }
    }
    
    @discardableResult
    internal func getMyProfile(completionHandler:@escaping (Profile?) -> ()) -> Request {
        let url = "\(self.baseEndpoint)v1/me"
        
        return self.apiRequest(method: .get, url: url) { response, error in
            
            if error == nil, let responseJSON = response.result.value as? [String:Any] {
                // Save new profile data in core data
                self.coreDataHandler.replaceEntities(json: [responseJSON], name: "Profile") { data in
                    
                    let profile = data?.first as? Profile
                    completionHandler(profile)
                }
            }
            // If it cant get a response or there is an error, get it from core data
            else {
                let profile = self.coreDataHandler.getEntity(entity: "Profile").first as? Profile
                completionHandler(profile)
            }
        }
    }
    
    @discardableResult
    internal func getUsersAlbums(limit:Int? = nil, offset:Int = 0, completionHandler:@escaping ([Album]) -> ()) -> Request {
        let url = "\(self.baseEndpoint)v1/me/albums"
        var params = [String:Any]()
        
        if limit != nil {
            params["limit"] = limit
        }
        
        params["offset"] = offset
        
        return self.apiRequest(params:params, method: .get, url: url) { response, error in
            
            let responseJSON = response.result.value as? [String:Any]
            let itemsJSON = responseJSON?["items"] as? [[String:Any]]
            
            if error == nil, let albumsJSON = itemsJSON?.map({$0["album"] as! [String:Any]}) {
                
                // Save albums in core data
                self.coreDataHandler.appendEntities(json: albumsJSON, name: "Album") { data in
                    
                    // Convert and return album array to completionHandler
                    if let albums = data as? [Album] {
                        completionHandler(albums)
                    }
                }
            }
            // If it cant get a response, try to get it from core data
            else if let albums = self.coreDataHandler.getEntity(entity: "Album") as? [Album] {
                completionHandler(albums)
            }
            else {
                completionHandler([Album]())
            }
        }
    }
    
}
