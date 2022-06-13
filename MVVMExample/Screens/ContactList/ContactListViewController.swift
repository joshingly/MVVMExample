//
//  ContactListViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation
import UIKit

private enum Action {
  case edit
  case create
}

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

  @objc func addPressed() { showForm(for: Contact(), .create) }

  override func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    showForm(for: data.contacts[indexPath.row], .edit)
  }

  private func showForm(for contact: Contact, _ action: Action) {
    let storyboard = UIStoryboard(name: "ContactForm", bundle: Bundle.main)
    let vc = storyboard.instantiateInitialViewController() as! ContactFormViewController
    vc.onSave = { [unowned self] contact in
      if action == .create { self.data.contacts.append(contact) }
      self.collectionView.reloadData()
    }
    vc.contactForm = ContactFormViewModel(contact)

    vc.modalPresentationStyle = .fullScreen

    present(vc, animated: true)
  }
}
