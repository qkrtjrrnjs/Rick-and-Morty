//
//  Coordinator.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/17/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
