//
//  SCViewModel.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 11/23/20.
//

import Foundation
import Parse

class SCViewModel {
    var objects: [SCObject] = []
    var isLoading = true
    
    func fetch(onCompletion complete: @escaping ([SCObject]?, Error?) -> Void) {
        complete(nil, nil)
    }
}
