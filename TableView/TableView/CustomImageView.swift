//
//  CustomImageView.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import UIKit

class CustomImageView: UIImageView {
    
    func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard
                let data = data,
                let newIamge = UIImage(data: data)
            else {
                print("Couldn't load image from url: \(url)")
                return
            }
            
            DispatchQueue.main.async {
                self.image = newIamge
            }
        }
        
        task.resume()
    }
}
