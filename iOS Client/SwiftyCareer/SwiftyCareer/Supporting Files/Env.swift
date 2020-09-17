//
//  Env.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import Foundation

import Foundation

class ENV {
#if DEBUG
    static let SERVER_URL = "http://Gellert-MacMini.local:1337/parse"
    static let APP_ID = "myAppId"
#elseif RELEASE
    static let SERVER_URL = "https://uniplusdev.herokuapp.com/parse"
    static let APP_ID = "ycUcZbElpxaa0UbV5wUGpGvjaj2wIbauRCyJFUyG"
#endif
}