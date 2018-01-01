//
//  Person.swift
//  HackingWithSwift - Project12a
//
//  Created by Patrick Flanagan on 12/23/17.
//  Copyright © 2017 Patrick Flanagan. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {

	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
	
	required init(coder aDecoder: NSCoder) {
		name = aDecoder.decodeObject(forKey: "name") as! String
		image = aDecoder.decodeObject(forKey: "image") as! String
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: "name")
		aCoder.encode(image, forKey: "image")
	}
	
	
}
