//
//  AlbumCollectionViewCell.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 27/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var coverImage: UIImageView!
    @IBOutlet fileprivate weak var Name: UILabel!
    @IBOutlet fileprivate weak var Artist: UILabel!
    
    var album: Album? {
        didSet {
            if album == nil {
                Name.text = ""
                Artist.text = "No artist"
            } else {
                Name.text = album?.name
                Artist.text = "AAA"
            }
        }
    }
    
}
