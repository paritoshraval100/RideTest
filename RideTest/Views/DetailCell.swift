//
//  DetailCell.swift
//  RideTest
//
//  Created by Paritosh_raval on 21/07/21.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var milageLable: UILabel!

    func update(vehicle: Vehicle) {
        titleLabel.text = vehicle.title
        milageLable.text = vehicle.milage
        imageView.imageFromServerURL(urlString: vehicle.vehicle_pic_absolute_url)
    }
}

