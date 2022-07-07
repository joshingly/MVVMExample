//
//  TodosEndpoint.swift
//  MVVMExample
//
//  Created by Joshua Antonishen on 7/7/22.
//

import Foundation
import PromiseKit

// Usage:
// _ = TodosEndpoint.show("1", using: "1234abcd").done { response in
//  print(response.data)
// }.catch { error in
//  print(error)
// }

enum TodosEndpoint {
  private enum Endpoint {
    case show(id: String)

    func path() -> String {
      switch self {
      case let .show(id: id): return "/todos/\(id)"
      }
    }
  }

  static func show(_ id: String, using token: String) -> Promise<APIResponse> {
    let request = APIRequest(
      .get,
      path: Endpoint.show(id: id).path(),
      headers: [.auth(token: token)]
    )
    return API.fire(request)
  }
}
