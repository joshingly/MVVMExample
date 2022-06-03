//
//  ContactFormViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormViewController: UIViewController {
  @IBOutlet var previousButton: UIButton!
  @IBOutlet var nextButton: UIButton!
  @IBOutlet var cancelButton: UIButton! { didSet {
    cancelButton.addTarget(self, action: #selector(pressCancel), for: .touchUpInside)
  }}
  @IBOutlet var saveButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  @objc func pressPrevious() {}
  @objc func pressNext() {}
  @objc func pressCancel() { self.dismiss(animated: true) }
  @objc func pressSave() {}

  func setup() {
    view.backgroundColor = .lightGray
  }
}
