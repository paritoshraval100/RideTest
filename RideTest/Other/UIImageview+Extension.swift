//
//  UIImageview+Extension.swift
//  RideTest
//
//  Created by Paritosh_raval on 22/07/21.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, defaultImage : String? = "noImage") {
        if let di = defaultImage {
            self.image = UIImage(named: di)
        }
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
