//
//  CalculadoraTest.swift
//  T1E02
//
//  Created by jngd on 24/08/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import XCTest

@testable import T1E02

class CalculadoraTest: XCTestCase {
	
	var calculadora: Calculadora!
	
	override func setUp() {
		super.setUp()
		self.calculadora = Calculadora()

	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testExample() {
	}
	
	func testPerformanceExample() {
		self.measureBlock {
		}
	}
	
	func testAdd(){
		self.calculadora.operator1 = 5
		self.calculadora.operator2 = 5
		self.calculadora.operation = "+"
		XCTAssertEqual(self.calculadora.makeOperation(),
		               10,"Error")
 }
	
}
