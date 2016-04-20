//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    var dateTxt:String!
    var liked: Bool
    var highQImage: String!

    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'\
        self.likes = data.objectForKey("likes")?.objectForKey("count") as? Int
        self.url = data.objectForKey("images")?.objectForKey("thumbnail")?.objectForKey("url") as? String
        self.username = data.objectForKey("caption")?.objectForKey("from")?.objectForKey("username") as? String
        self.liked = false
        let parseNum = Double((data.objectForKey("caption")?.objectForKey("created_time") as? String)!)
        self.dateTxt = NSDate(timeIntervalSince1970: (parseNum)!).descriptionWithLocale(_: nil)
        self.highQImage = data.objectForKey("images")?.objectForKey("standard_resolution")?.objectForKey("url") as? String
    }
}