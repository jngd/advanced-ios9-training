/**
* Copyright (c) 2016 Juan Garcia
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {

	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var textView: UITextView!

	@IBAction func send(sender: AnyObject) {
		showBrowserVC()
	}

	var browserVC:MCBrowserViewController!
	var advertiserAssistant: MCAdvertiserAssistant!
	var session: MCSession!
	var peerID: MCPeerID!

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpMultipeer()
	}

	func setUpMultipeer(){
		peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
		session = MCSession(peer: peerID)
		session.delegate = self
		browserVC = MCBrowserViewController(serviceType: "chat", session: session)
		browserVC.delegate = self
		advertiserAssistant = MCAdvertiserAssistant(serviceType: "chat",
		                                            discoveryInfo: nil, session: session)
	}

	func sendMessage() {
		let message = self.textField.text
		self.textField.text = ""

		let data = message?.dataUsingEncoding(NSUTF8StringEncoding)

		do {
			try self.session.sendData(data!, toPeers: self.session.connectedPeers, withMode: .Unreliable)
			self.receiveMessage(message!, peer: self.peerID)
		} catch let error as NSError {
			print("Send failed \(error.localizedDescription)")
		}

	}

	func receiveMessage(message: String, peer: MCPeerID) {
		var text: String!

		text = peer == self.peerID ? "\nI: \(message)"
		                           : "\n\(peer.displayName): \(message)"

		self.textView.text = self.textView.text.stringByAppendingString(text)
	}

	func dismissBrowserVC() {
		self.browserVC.dismissViewControllerAnimated(true, completion: nil)
	}

	func showBrowserVC() {
		self.presentViewController(self.browserVC, animated: true, completion: nil)
	}

}

extension ViewController: UITextFieldDelegate {

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		self.sendMessage()

		return true
	}

}

extension ViewController: MCSessionDelegate {

	func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
		let message = NSString(data: data, encoding: NSUTF8StringEncoding) as! String

		dispatch_async(dispatch_get_main_queue(), {
			self.receiveMessage(message, peer: peerID)
		})
	}

	func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}

	func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {}

	func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {}

	func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {}

}

extension ViewController: MCBrowserViewControllerDelegate {

	func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
		self.dismissBrowserVC()
	}

	func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
		self.showBrowserVC()
	}

}