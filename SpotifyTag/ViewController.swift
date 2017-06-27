//
//  ViewController.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 18/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let auth = OAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func login(_ sender: Any) {
        auth.authorize()
    }
}

