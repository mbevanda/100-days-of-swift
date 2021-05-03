//
//  ViewController.swift
//  013NamesToFaces
//
//  Created by Maja Bevada on 03.05.2021..
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            //we failed to get a PersonCell - bail out!
            fatalError("Unable to dequeue PersonCell.")
        }
        return cell
    }


}

