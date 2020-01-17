//
//  GetSetCommand.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/16/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation

protocol GetSetCommand {
    func execute()
}

extension GetSetCommand {
    func getDateFormat() -> String {
        return Date().getString(with: "yyyy-MM-dd HH:mm:ss")
    }
}
