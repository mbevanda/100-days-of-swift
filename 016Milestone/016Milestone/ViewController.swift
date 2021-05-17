//
//  ViewController.swift
//  016Milestone
//
//  Created by Maja Bevada on 14.05.2021..
//

import UIKit

class ViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var userPhotos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userPhotos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let photo = userPhotos[indexPath.row]
        cell.textLabel?.text = photo.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = userPhotos[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        
        
        let ac = UIAlertController(title: "Chose action", message: "Do you want to load photo or rename it", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Load", style: .default){ [ weak self ] _ in
            if let vs = self?.storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
                vs.selectedImage = path.path
                self?.navigationController?.pushViewController(vs, animated: true)
            }
        })
        ac.addAction(UIAlertAction(title: "Rename", style: .default){ [ weak self ] _ in
            self?.renamePhoto(photo)
        })
        present(ac, animated: true)
    }
    
    func renamePhoto(_ photo: Photo) {
        let ac = UIAlertController(title: "Rename photo", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            photo.name = newName
            
            self?.tableView.reloadData()
        })
        
        present(ac, animated: true)
    }
    
    @objc func addPhoto(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Extract the image from the dictionary that is passed as a parameter
        guard let image = info[.editedImage] as? UIImage else { return }

        //Generate a unique filename for it
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        //Convert it to a JPEG, then write that JPEG to disk
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(name: "Unknown", image: imageName)
        userPhotos.append(photo)
        tableView.reloadData()

        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

