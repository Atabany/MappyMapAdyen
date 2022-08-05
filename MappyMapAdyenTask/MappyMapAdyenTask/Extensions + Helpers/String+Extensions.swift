//
//  String+Extensions.swift
//  MappyMapAdyenTask
//
//  Created by Mohamed Elatabany on 05/08/2022.
//

import Foundation
import UIKit

extension Optional where Wrapped == String  {
    var emptyTextIfNill: String  {
        return self ?? ""
    }
}
