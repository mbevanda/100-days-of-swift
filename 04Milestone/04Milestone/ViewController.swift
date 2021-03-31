//
//  ViewController.swift
//  04Milestone
//
//  Created by Maja Bevada on 31.03.2021..
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.textLabel?.text = countries[indexPath.row].uppercased()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

