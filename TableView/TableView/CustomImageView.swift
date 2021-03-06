//
//  CustomImageView.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    // Global variable to hold the dataTask
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL) {
        // Override the previous image to blank space
        image = nil
        
        addSpinner()
        
        // If there was a dataTask that was already doing stuff, just cancel it
        if let task = task {
            task.cancel()
        }
        
        // If the image from the url is in the Cache use that instead
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            image = imageFromCache
            removeSpinner()
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print("Couldn't load image from url: \(url)")
                return
            }
            
            // Saving the image with an unique identifier base on the url of the image
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        
        task.resume()
    }
    
    func addSpinner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
