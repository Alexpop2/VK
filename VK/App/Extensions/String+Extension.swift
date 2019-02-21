//
//  String+Extension.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
