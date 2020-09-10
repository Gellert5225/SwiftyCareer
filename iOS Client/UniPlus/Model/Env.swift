//
//  Env.swift
//  UniPlus
//
//  Created by Gellert Li on 9/9/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

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
