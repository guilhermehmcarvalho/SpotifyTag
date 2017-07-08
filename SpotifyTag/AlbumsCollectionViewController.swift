//
//  AlbumsCollectionViewController.swift
//  SpotifyTag
//
//  Created by Guilherme Carvalho on 27/06/2017.
//  Copyright © 2017 gboxx. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "AlbumCell"

class AlbumsCollectionViewController: UICollectionViewController {
    
    fileprivate var albumList = [Album]()
    private let api = SpotifyAPIHandler()
    private let refreshControl = UIRefreshControl()
    private var request:Request?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // refreshControl setup
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            collectionView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(self.loadAlbums), for: .valueChanged)

        loadAlbums()
    }

    @objc private func loadAlbums() {
        if request == nil {
            let lastId = albumList.count
            request = api.getUsersAlbums(limit: 25, offset: lastId) {
                albums in
                //self.albumList.append(contentsOf: albums)
                self.albumList = albums
                self.collectionView?.reloadData()
                self.refreshControl.endRefreshing()
                self.request = nil
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadAlbums()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return albumList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCollectionViewCell
    
        // Configure the cell
        cell.album = albumList[indexPath.row]
    
        return cell
    }
}
