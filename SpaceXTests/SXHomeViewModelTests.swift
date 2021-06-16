//
//  SXHomeViewModelTests.swift
//  SXHomeViewModelTests
//
//  Created by Abbut john on 11/06/2021.
//

import XCTest
@testable import SpaceX

class SXHomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCallFuncToGetRocketData() {
        
        let expectations = self.expectation(description: "GetRocketsData")
        APIClient.getRockets{ result in
            switch result {
            case .success(let rockets):
                XCTAssertNotNil(rockets)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectations.fulfill()
        }
        waitForExpectations(timeout: 0.01, handler: nil)
    }
    
    func testCellViewModel() {
        
        let rocketInfo = Rocket(id: "abc", name: "abc", success_rate_pct: 0, first_flight: "2006-03-24", active: false, flickr_images: ["abc"], country: "abc", description: "abc", cost_per_launch: 0, wikipedia: "abc")
        let rocketCellViewModel = RocketCellViewModel(rocket: rocketInfo)
        

        XCTAssertEqual(rocketCellViewModel.id, rocketInfo.id)
        XCTAssertEqual(rocketCellViewModel.name, rocketInfo.name)
        XCTAssertEqual(rocketCellViewModel.success_rate_pct, "\(rocketInfo.success_rate_pct)" + "%")
        XCTAssertEqual(rocketCellViewModel.success_color, .red)
        XCTAssertEqual(rocketCellViewModel.first_flight, "24 Mar 2006")
        XCTAssertEqual(rocketCellViewModel.active, rocketInfo.active)
        XCTAssertEqual(rocketCellViewModel.imageURL, rocketInfo.flickr_images.first)
        XCTAssertEqual(rocketCellViewModel.country, rocketInfo.country)
        XCTAssertEqual(rocketCellViewModel.description, rocketInfo.description)
        XCTAssertEqual(rocketCellViewModel.cost_per_launch, rocketInfo.cost_per_launch)
        XCTAssertEqual(rocketCellViewModel.wikipedia, rocketInfo.wikipedia)

    }

}
