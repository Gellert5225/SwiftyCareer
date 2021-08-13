//
//  SCWebAPITests.swift
//  SCWebAPITests
//
//  Created by Gellert Li on 8/8/21.
//

import XCTest
@testable import SCWebAPI

class SCWebAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let config = SCWebAPIConfiguration(serverURL: "http://192.168.1.16:1336")
        SCWebAPI.Initialize(with: config)
        
        let xhr = SCXHR()
        
        let signin = SCResource(path: "/api/rest/auth/signin", method: .POST, params: ["username": "d_schrute", "password": "5917738ljh"])
        let jwt = SCResource(path: "/testCookieJwt")
        let feeds = SCResource(path: "/feeds")
        let image = SCResource(path: "/api/files/3d7fc74f01f7162fef98a1c145f15dfc.jpg")
        
        xhr.request(resource: feeds) {response in
            if let error = response.err {
                print("OOPS")
                print(error)
            }
            
            print(response.res!.count)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
