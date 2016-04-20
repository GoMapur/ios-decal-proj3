//
//  PhotoDetailViewController.swift
//  Photos
//
//  Created by Mingjian Lu on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var photo: Photo!
    
    @IBAction func dismissWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
        if photo.liked {
            likeButton.selected = false
        } else {
            likeButton.selected = true
        }
        let url = NSURL(string: photo.highQImage)
        getDataFromUrl(url!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                self.displayImage.image = UIImage(data: data)
            }
        }
        self.author.text = photo.username
        self.date.text = photo.dateTxt
        self.likeNum.text = "\(photo.likes)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(sender: UIButton) {
        if sender.selected {
            // deselect
            photo.liked = false
            photo.likes = photo.likes - 1
            sender.selected = false
            self.likeNum.text = "\(photo.likes)"
        } else {
            // select with animation
            photo.liked = true
            photo.likes = photo.likes + 1
            sender.selected = true
            self.likeNum.text = "\(photo.likes)"
        }
    }
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
