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

        // Do any additional setup after loading the view.
        
        SpotifyAPIHandler().getMyProfile() {
            profile in
            
            if let name = profile?.display_name {
                print(name)
            }
        }
        
        SpotifyAPIHandler().getUsersAlbums()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoff(_ sender: Any) {
        OAuth().logout()
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
