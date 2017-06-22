//
//  LoggedInViewController.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 22/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAlbums();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func getAlbums(){
        let url = "\(SpotifyBaseEndpoint)v1/me/albums"
        
        NetworkManager.shared.sessionManager.request(url, method: .get)
            .responseJSON{ response in
                print(response)
        }
    }
    
    @IBAction func logoff(_ sender: Any) {
        OAuth().logout(viewController: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
