//
//  ViewController.swift
//  HackingWithSwift - Project12a
//
//  Created by Patrick Flanagan on 12/23/17.
//  Copyright © 2017 Patrick Flanagan. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var people = [Person]()
	
	func save() {
		let savedData = NSKeyedArchiver.archivedData(withRootObject: people)
		let defaults = UserDefaults.standard
		defaults.set(savedData, forKey: "people")
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
	
		let defaults = UserDefaults.standard
		
		if let savedPeople = defaults.object(forKey: "people") as? Data {
			people = NSKeyedUnarchiver.unarchiveObject(with: savedPeople) as! [Person]
		}
		
		
	}

	@objc func addNewPerson() {
		
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {return}
		
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		
		if let jpegData = UIImageJPEGRepresentation(image, 80) {
			
			try? jpegData.write(to: imagePath)
			
		}
		
		let person = Person(name: "Unknown", image: imageName)
		people.append(person)
		collectionView?.reloadData()
		
		dismiss(animated: true)
		
	}
	
	func getDocumentsDirectory() -> URL {
		
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return people.count

	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
		
		let person = people[indexPath.item]
		
		cell.name.text = person.name
		
		let path = getDocumentsDirectory().appendingPathComponent(person.image)
		cell.imageView.image = UIImage(contentsOfFile: path.path)
		
		cell .imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
		cell.imageView.layer.borderWidth = 2
		cell.imageView.layer.cornerRadius = 7
		
		return cell
		
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let person = people[indexPath.item]
		
		let ac = UIAlertController(title:  "Rename person", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		
		ac.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self, ac] _ in
			
			let newName = ac.textFields![0]
			person.name = newName.text!
			
			self.collectionView?.reloadData()
			self.save()
			
		})
		
		present(ac, animated: true)
		
	}
	
	

}

