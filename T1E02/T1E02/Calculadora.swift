//
//  Calculadora.swift
//  T1E02
//
//  Created by jngd on 24/08/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import Foundation
import UIKit

class Calculadora: NSObject {
	var operation = "@"
	var operator1 = 0.0
	var operator2 = 0.0
	func makeOperation() -> Double{
		var result = 0.0
		switch(operation){
		case "+":
			result = self.add()
		case "-":
			result = self.substract()
		case "*":
			result = self.multiply()
		case "/":
			result = self.divide()
		default:
			break
		}
		return result
	}
	func add() -> Double {
		return operator1 + operator2
	}
	func substract() -> Double {
		return operator1 - operator2
	}
	func multiply() -> Double {
		return operator1 * operator2
	}
	func divide() -> Double {
		if(operator2 == 0){
			return 0.0 }
		return operator1 / operator2
	}
}