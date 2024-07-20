//
//  CalculateHeight.swift
//  threads-clone
//
//  Created by Abdulrahman Ibrahim on 20.07.24.
//

import Foundation
import SwiftUI

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
