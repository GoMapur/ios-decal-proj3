//
//  PhotosCollectionViewCell.swift
//  Photos
//
//  Created by Mingjian Lu on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var displayImage: UIImageView!
    var url: String?
    var photo: Photo?
}

