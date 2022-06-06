//
//  ContactFormViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormViewController: UIViewController {
  @IBOutlet var previousButton: UIButton! { didSet {
    previousButton.addTarget(self, action: #selector(pressPrevious), for: .touchUpInside)
  }}
  @IBOutlet var nextButton: UIButton! { didSet {
    nextButton.addTarget(self, action: #selector(pressNext), for: .touchUpInside)
  }}
  @IBOutlet var cancelButton: UIButton! { didSet {
    cancelButton.addTarget(self, action: #selector(pressCancel), for: .touchUpInside)
  }}
  @IBOutlet var saveButton: UIButton!

  @IBOutlet var contactFormPagesView: ContactFormPagesView! { didSet {
    contactFormPagesView.viewController = self
    contactFormPagesView.setup()

    for vc in contactFormPagesView.pages {
      vc._viewModel.contact = contactForm.contact
      contactForm.pages.append(vc._viewModel)
    }
  } }

  var contactForm: ContactFormViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    view.backgroundColor = .lightGray
  }

  @objc func pressPrevious() { contactFormPagesView.previousPage() }
  @objc func pressNext() { contactFormPagesView.nextPage() }
  @objc func pressCancel() { dismiss(animated: true) }
  @objc func pressSave() {}
}
