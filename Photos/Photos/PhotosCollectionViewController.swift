//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
    }
    
    /*
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotosCollectionCell", forIndexPath: indexPath) as! PhotosCollectionViewCell
        let photo = photos[indexPath.row] as Photo
        loadImageForCell(photo, imageView: cell.displayImage)
        cell.url = photo.url
        cell.photo = photo
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("CollectionToDetail", sender: photos[indexPath.item])
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage.
     It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url = NSURL(string:photo.url)
        let data = NSData(contentsOfURL: url!)
        imageView.image = UIImage(data: data!)
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController2 = segue.destinationViewController as? PhotoDetailViewController {
            if let senderPhoto = sender as? Photo {
                viewController2.photo = senderPhoto
            }
        }
    }
}

