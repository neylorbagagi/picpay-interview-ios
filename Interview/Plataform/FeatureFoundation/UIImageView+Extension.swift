//
//  UIImageView+Extension.swift
//  Interview
//
//  Created by Neylor Bagagi on 08/07/25.
//  Copyright © 2025 PicPay. All rights reserved.
//

import UIKit

let cache = NSCache<NSString, UIImage>()

public extension UIImageView {
    
    func setImage(from stringURL: String) {
        image = UIImage(systemName: "photo")
        
        guard let url = URL(string: stringURL) else { return }
        
        if let imageCache = cache.object(forKey: url.absoluteString as NSString) {
            self.image = imageCache
            return
        }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                cache.setObject(image, forKey: url.absoluteString as NSString)
                self.image = image
            }
        }.resume()
    }
}
