//
//  String+Extension.swift
//  ImageLoader
//
//  Created by Viresh Singh on 07/02/19.
//  Copyright © 2019 Viresh Singh. All rights reserved.
//

import UIKit

extension String
{
    func trim() -> String {
        if(self.count <= 0)
        {
            return self
        }
        var finalstring = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        finalstring = finalstring.replacingOccurrences(of: " ", with: "")
        return finalstring
    }
}
