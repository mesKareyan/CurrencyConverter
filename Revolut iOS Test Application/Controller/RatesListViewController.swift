//
//  RatesListViewController.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

protocol CurrencyListProvider {
	func startUpdating()
	func stopUpdating()
	var tableView: UITableView! { get set }
}

class RatesListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	var dataProvider: CurrencyListProvider!
	var listDelegate = CurrencyListDelegate()
	var tapToHideKeyboardGesture: UITapGestureRecognizer?
	
	//MARK - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		dataProvider.tableView = tableView
		tableView.delegate = listDelegate
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		dataProvider.startUpdating()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		dataProvider.stopUpdating()
	}
	
	//MARK - Keyboard
	@objc func keyboardWillShow(notification: Notification) {
		tapToHideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
		view.addGestureRecognizer(tapToHideKeyboardGesture!)
	}
	
	@objc func keyboardWillHide(notification: Notification) {
		if let tap = tapToHideKeyboardGesture  {
			view.removeGestureRecognizer(tap)
		}
	}
	
	@objc func endEditing() {
		self.view.endEditing(true)
	}
	
}



