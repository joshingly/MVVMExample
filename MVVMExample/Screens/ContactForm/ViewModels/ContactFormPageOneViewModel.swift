//
//  ContactFormPageOneViewModel.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/6/22.
//

import Foundation

class ContactFormPageOneViewModel: ContactFormPageViewModel {
  var contact: Contact!
  var UIupdateFields: () -> Void = {}

  var name: String = ""
  var location: String = ""
}
