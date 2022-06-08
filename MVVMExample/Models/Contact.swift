//
//  Contact.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 6/2/22.
//

import Foundation

class Contact {
  var name: String
  var location: String
  var age: Int?
  var birthday: Date?
  var kind: String

  init(
    name: String = "",
    location: String = "",
    age: Int? = nil,
    birthday: Date? = nil,
    kind: String = ""
  ) {
    self.name = name
    self.location = location
    self.age = age
    self.birthday = birthday
    self.kind = kind
  }
}
