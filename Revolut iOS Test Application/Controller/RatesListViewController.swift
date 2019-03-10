//
//  RatesListViewController.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

class RatesListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	var listDataSource: CurrencyListDataSource?
	var listDelegate = CurrencyListDelegate()
	var tapToHideKeyboardGesture: UITapGestureRecognizer?
	
	//MARK - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = listDataSource
		listDataSource?.tableView = tableView
		tableView.delegate = listDelegate
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		listDataSource?.startUpdating()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		listDataSource?.stopUpdating()
	}
	
	//MARK - Keyboard
	@objc func keyboardWillShow(notification: Notification) {
		tapToHideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
		self.view.addGestureRecognizer(tapToHideKeyboardGesture!)
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



