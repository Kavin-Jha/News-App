//
//  ProductCollectionViewCell.swift
//  ApICaller
//
//  Created by Kavin Jha on 13/07/23.
//

import UIKit

class ImageCacher {
    static var dict: [String: Data] = [:]
}

class ImageDownloader {
    
    //TODO: Read about Escaping Closure
    func getImage(_ url: URL, onCompletion: @escaping (_ image: UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error = error {
                print("😇 Error: \(error)")
                DispatchQueue.main.async {
                    onCompletion(nil)
                }
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    let donwloadedImage = UIImage(data: data)
                    onCompletion(donwloadedImage)
                }
            }
        }.resume()
    }
    
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    let imageDownloader = ImageDownloader()
    
    @IBOutlet weak var customPhotoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialize(_ imageURL: URL?, index: Int) {
        //TODO: Download URL
        
        guard let imageString = imageURL?.absoluteString,
        let imageURL = URL(string: imageString) else {
            return
        }
        
        if let data = ImageCacher.dict[imageString] {
            print("📦 From Cache: \(imageString) : \(data)")
            self.customPhotoView.image = UIImage(data: data)
        } else {
            imageDownloader.getImage(imageURL) { image in
                print("🌎 Image Download: \(imageString)")
                ImageCacher.dict[imageURL.absoluteString] = image?.jpegData(compressionQuality: 0.5)
                
                if index == self.tag {
                    self.customPhotoView.image = image
                } else {
                print("Mismatch....")
                }
            }
            
//            DispatchQueue.global().async {
//
//                if let imageURL = imageURL, let data = try? Data(contentsOf: imageURL) {
//
//                    DispatchQueue.main.async {
//
//                        ImageCacher.dict[imageURL.absoluteString] = data
//
//                        if index == self.tag {
//                            print("🌎 From Internet: \(imageURL.absoluteString)")
//                            self.customPhotoView.image = UIImage(data: data)
//                        } else {
//                            print("Mismatch....")
//                        }
//                    }
//                }
//            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.customPhotoView.image = nil
    }
    
    
}
