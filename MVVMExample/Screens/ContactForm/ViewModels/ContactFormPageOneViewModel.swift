//
//  ContactFormPageOneViewModel.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/6/22.
//

import Foundation

class ContactFormPageOneViewModel: ContactFormPageViewModel {
  var contact: Contact! { didSet {
    name = contact.name
    location = contact.location
  }}
  var UIupdateFields: () -> Void = {}

  var name: String = ""
  var location: String = ""

  func save() {
    contact.name = name
    contact.location = location
  }
}
