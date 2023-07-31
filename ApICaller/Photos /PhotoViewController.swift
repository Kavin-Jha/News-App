//
//  PhotoViewController.swift
//  ApICaller
//
//  Created by Kavin Jha on 13/07/23.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photoView: UICollectionView!
    
    public var data = [PhotosData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "ProductCollectionViewCell", bundle: nil )
        photoView.register(nibCell, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        let anonymousFunction = { (fetchedData: Data) in
            
            guard let userData = try? JSONDecoder().decode([PhotosData].self, from: fetchedData) else {
                
                print("Couldn't decode JSON")
                return
            }
            
            self.data = userData
            self.photoView.reloadData()
        }
        
        APICaller.shared.request(url: URL(string: "https://jsonplaceholder.typicode.com/photos")!, onCompletion: anonymousFunction)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = photoView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell
        
        let fileUrl = URL(string: data[indexPath.row].thumbnailUrl!)
        cell?.tag = indexPath.row
        cell?.initialize(fileUrl, index: indexPath.row)
        
        return cell!
    }
    
    
}
