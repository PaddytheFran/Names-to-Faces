//
//  Person.swift
//  HackingWithSwift - Project10
//
//  Created by Patrick Flanagan on 12/23/17.
//  Copyright © 2017 Patrick Flanagan. All rights reserved.
//

import UIKit

class Person: NSObject {

	var name: String
	var image: String
	
	init(name: String, image: String) {
		self.name = name
		self.image = image
	}
	
}
