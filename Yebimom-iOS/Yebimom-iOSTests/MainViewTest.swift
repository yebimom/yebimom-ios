//
//  MainViewTest.swift
//  Yebimom-iOS
//
//  Created by wikibootup on 6/12/15.
//  Copyright (c) 2015 wikibootup. All rights reserved.

// Referenced by : https://swift.unicorn.tv/articles/introduction-to-xctest

import UIKit
import XCTest

class MainViewTest: XCTestCase {
    

    func testViewDidLoad()
    {
        var mainViewController = MainTableViewController()
        XCTAssertNotNil(mainViewController.view, "View Did Not load")
    }

}
