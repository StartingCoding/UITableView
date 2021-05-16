//
//  CustomImageView.swift
//  TableView
//
//  Created by Loris on 16/05/21.
//

import UIKit

class CustomImageView: UIImageView {
    // Global variable to hold the dataTask
    var task: URLSessionDataTask!
    
    func loadImage(from url: URL) {
        // Override the previous image to blank space
        image = nil
        
        // If there was a dataTask that was already doing stuff, just cancel it
        if let task = task {
            task.cancel()
        }
        
        task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            
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
