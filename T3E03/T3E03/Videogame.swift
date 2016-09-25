//
//  Videogame.swift
//  T3E03
//
//  Created by jngd on 25/09/16.
//  Copyright © 2016 jngd. All rights reserved.
//

import UIKit
import SpriteKit

class Videogame: SKScene, SKPhysicsContactDelegate {
	
	let score = SKLabelNode(fontNamed:"Chalkduster")
	
	var target : SKSpriteNode!
	var points = 0
	var value : Float = 0.0
	var player : SKSpriteNode = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(100, 50))
	
	enum ColliderType : UInt32 {
		case Player = 0
		case Target = 1
	}
	
	override func didMoveToView(view: SKView) {
		self.physicsWorld.contactDelegate = self
		let size2 = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)
		self.physicsBody = SKPhysicsBody(edgeLoopFromRect:size2)
		
		player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(100, 50))
		player.position = CGPoint(x:CGRectGetMidX(self.frame),
		                          y:CGRectGetMidY(self.frame))
		player.name = "Player"
		player.physicsBody?.categoryBitMask = ColliderType.Player.rawValue
		player.physicsBody?.collisionBitMask = ColliderType.Target.rawValue
		player.physicsBody?.contactTestBitMask = ColliderType.Target.rawValue
		self.addChild(player)
		
		target = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(40, 20))
		target.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(40, 20))
		target.physicsBody?.dynamic = false
		target.position = CGPointMake(200, 530)
		target.name = "Target"
		target.physicsBody?.categoryBitMask = ColliderType.Target.rawValue
		target.physicsBody?.collisionBitMask = ColliderType.Player.rawValue
		target.physicsBody?.contactTestBitMask = ColliderType.Player.rawValue
		self.addChild(target)
		
		let movement = SKAction.sequence([SKAction.moveTo(CGPointMake(0, 530),
			duration: 2.0),SKAction.moveTo(CGPointMake(self.frame.size.width, 530), duration:
				2.0)])
		let constMovement = SKAction.repeatActionForever(movement)
		target.runAction(constMovement)
		
		let slider = UISlider(frame: CGRectMake(0, 0, 325, 100))
		slider.addTarget(self, action: #selector(Videogame.manageSlider(_:)), forControlEvents:
			UIControlEvents.ValueChanged)
		slider.minimumValue = 0
		slider.maximumValue = Float(self.frame.size.width)
		view.addSubview(slider)
		
		score.text = "Score: \(points)"
		score.name = "Points"
		score.fontSize = 50;
		score.position = CGPoint(x:CGRectGetMidX(self.frame),
		                         y:CGRectGetMidY(self.frame))
		self.addChild(score)
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		var operation:CGFloat = 250.0
		operation *= (CGFloat)(self.value)
		self.childNodeWithName("Player")?.physicsBody?.applyForce(CGVectorMake(
			operation, 20000))
	}
	
	func didBeginContact(contact: SKPhysicsContact) {
		var firstBody:SKPhysicsBody
		var secondBody:SKPhysicsBody
		if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
			firstBody = contact.bodyA
			secondBody = contact.bodyB
		} else {
			firstBody = contact.bodyB
			secondBody = contact.bodyA
		}
		
		if(firstBody.categoryBitMask == 1 && secondBody.categoryBitMask == 2){
			points = points + 1
			self.childNodeWithName("Points")?.removeFromParent()
			score.text = "Score: \(points)";
			self.addChild(score)
			secondBody.node?.removeFromParent()
			let delay = SKAction.waitForDuration(1)
			let generate = SKAction.runBlock({
				self.addChild(self.target)
			})
			let secuence = SKAction.sequence([delay, generate])
			self.runAction(secuence)
		}
	}
	
	func manageSlider(sender: UISlider) {
		print(sender.value)
		player.position = CGPoint(x:CGFloat(sender.value + 50),
		                          y:CGRectGetMidY(self.frame))
	}
}
