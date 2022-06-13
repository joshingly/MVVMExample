//
//  ContactFormPageTwoViewModel.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/6/22.
//

import Foundation

class ContactFormPageTwoViewModel: ContactFormPageViewModel {
  var contact: Contact! { didSet {
    kind = contact.kind
    birthday = contact.birthday
  }}
  var UIupdateFields: () -> Void = {}

  var kind: String?
  var birthday: Date?

  func save() {
    contact.kind = kind
    contact.birthday = birthday
  }
}
