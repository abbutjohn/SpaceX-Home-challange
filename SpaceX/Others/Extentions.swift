//
//  Extentions.swift
//  SpaceX
//
//  Created by Abbut john on 16/06/2021.
//

import Foundation
import UIKit

extension Date {
    
    func getFormattedDate(format: String) -> String {
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


//MARK: Loading Image


extension UIImageView {
    func donloadImage(fromUrl url: URL, id: String) {
        
        //Check cache
        if CoreDataManager.IsImageExistInDb(withId: id) {
            DispatchQueue.main.async() { () -> Void in
                self.image = UIImage(data:  (CoreDataManager.loadImage(withId: id).first?.image)!)
            }
        }else{
            //Call api when not in cache
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { () -> Void in
                    CoreDataManager.saveRocket(id: id, image: image)//Save to Cache when not available
                    self.image = image
                }
            }.resume()
        }
    }
}
