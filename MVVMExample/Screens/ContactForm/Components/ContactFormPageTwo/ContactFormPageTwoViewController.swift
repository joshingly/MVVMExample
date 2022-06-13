//
//  ContactFormPageTwoViewController.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/3/22.
//

import Foundation
import UIKit

class ContactFormPageTwoViewController: UIViewController, ContactFormPageViewController {
  var _viewModel: ContactFormPageViewModel! = ContactFormPageTwoViewModel()
  var viewModel: ContactFormPageTwoViewModel { _viewModel as! ContactFormPageTwoViewModel }

  private lazy var birthdayDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker(frame: .zero)
    datePicker.datePickerMode = .date
    datePicker.timeZone = TimeZone.current
    datePicker.preferredDatePickerStyle = .inline
    return datePicker
  }()

  @IBOutlet var birthday: MPFormField! { didSet {
    birthday.userEditable = false
    birthday.field.tintColor = .clear
    birthday.field.inputView = birthdayDatePicker
    birthday.field.inputAssistantItem.trailingBarButtonGroups.removeAll()
    birthday.field.inputAssistantItem.leadingBarButtonGroups.removeAll()

    birthdayDatePicker.addTarget(self, action: #selector(birthdayChanged), for: .valueChanged)
  }}

  @IBOutlet var kind: MPFormField! { didSet {
    kind.field.isUserInteractionEnabled = false

    let tap = UITapGestureRecognizer(target: self, action: #selector(showKindPicker))
    kind.addGestureRecognizer(tap)
  }}

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
    self.view.addGestureRecognizer(tap)
    view.backgroundColor = .green
  }

  @objc func birthdayChanged() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"

    birthday.field.text = dateFormatter.string(from: birthdayDatePicker.date)
    viewModel.birthday = birthdayDatePicker.date
    birthdayDatePicker.resignFirstResponder()
    birthday.field.endEditing(true)
  }

  @objc func dismissDatePicker() { birthday.field.endEditing(true) }
  @objc func showKindPicker() {
    let items: [PickerOption] = [
      .init(id: "uuid1", name: "Something"),
      .init(id: "uuid2", name: "Something Else"),
      .init(id: "uuid3", name: "Another"),
      .init(id: "uuid4", name: "Yet Another"),
      .init(id: "uuid5", name: "Another One"),
    ]
    let selectedIndex = items.firstIndex(where: { $0.name == viewModel.kind })

    let vc = PickerViewController.get(
      items: items,
      selectedIndex: selectedIndex
    ) { [unowned self] option in
      if let option = option {
        self.kind.field.text = option.name
        self.viewModel.kind = option.name
      } else {
        self.kind.field.text = ""
        self.viewModel.kind = nil
      }
    }

    vc.modalPresentationStyle = .pageSheet

    present(vc, animated: true)
  }
}
