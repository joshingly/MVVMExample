//
//  MPFormField.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/8/22.
//

import Foundation
import UIKit

@IBDesignable
class MPFormField: UIView, NibLoadable, UITextFieldDelegate {
  var ibTag: Int = 111

  @IBOutlet var field: UITextField! { didSet {
    field.delegate = self
  } }

  @IBAction func changed(_: Any) { onChange(field.text ?? "") }
  var onChange = { (_: String) in }
  var userEditable = true

  func setup() {}

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    customAwakeAfter(superAwakeAfter: { super.awakeAfter(using: aDecoder) })
  }

  override func prepareForInterfaceBuilder() {
    makeIBDesignable()
    super.prepareForInterfaceBuilder()
  }

  func textField(_: UITextField, shouldChangeCharactersIn _: NSRange, replacementString _: String) -> Bool {
    userEditable
  }
}
