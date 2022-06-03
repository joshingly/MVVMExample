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

  @IBOutlet var formPagesView: FormPagesView! { didSet { formPagesView.setup() } }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    view.backgroundColor = .lightGray
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    formPagesView.sizePages()
  }

  @objc func pressPrevious() { formPagesView.previousPage() }
  @objc func pressNext() { formPagesView.nextPage() }
  @objc func pressCancel() { dismiss(animated: true) }
  @objc func pressSave() {}
}
