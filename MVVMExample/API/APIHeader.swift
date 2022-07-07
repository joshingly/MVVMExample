//
//  APIHeader.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 7/7/22.
//

import Foundation

enum APIHeader {
  case auth(token: String)

  func key() -> String {
    switch self {
    case .auth: return "Authorization"
    }
  }

  func value() -> String {
    switch self {
    case let .auth(token): return "Token token='\(token)'"
    }
  }
}
