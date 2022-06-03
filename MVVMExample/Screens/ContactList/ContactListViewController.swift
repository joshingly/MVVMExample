//
//  ContactListCollectionViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation
import UIKit

class ContactListViewController: UICollectionViewController {
  let data = ContactListDataSource()

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.delegate = self
    collectionView.dataSource = data
    data.registerCells(for: collectionView)

    setup()
  }

  func setup() {
    setupNavBar()
  }

  func setupNavBar() {
    navigationItem.title = "Contacts"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addPressed)
    )
  }

  @objc func addPressed() {
    let storyboard = UIStoryboard(name: "ContactForm", bundle: Bundle.main)
    let vc = storyboard.instantiateInitialViewController() as! ContactFormViewController

    vc.modalPresentationStyle = .fullScreen

    present(vc, animated: true)
  }
}
