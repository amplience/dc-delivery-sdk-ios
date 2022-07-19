//
//  amplience_sdk_ios_fullUnitTests.swift
//  amplience-sdk-ios-fullUnitTests
//
//  Created by Maksym Paidych on 19.07.2022.
//

import XCTest
import Amplience
import amplience_sdk_ios_full

class amplience_sdk_ios_fullUnitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetImageURL() throws {
        let testImageItem: AmplienceImage = AmplienceImage(dict: ["defaultHost": "cdn.media.amplience.net", "id": "dff04dbe-8664-4531-bc9a-60e6f5df6fab", "endpoint": "ampproduct", "name": "Hero-Banner-720-model2"])
        let testImageItemURL = "https://cdn.media.amplience.net/i/ampproduct/Hero-Banner-720-model2"
        assert(testImageItemURL == testImageItem.getImageUrl(builder: ImageUrlBuilder()))
    }

    func testGetVideoURL() throws {
        let testVideoItem = AmplienceVideo(dict: ["defaultHost": "cdn.media.amplience.net", "id": "a6879dc9-067f-4132-942e-0c7a10320f81", "endpoint": "ampproduct", "name": "ski-collection"])
        let testVideoItemURL = "https://cdn.media.amplience.net/v/ampproduct/ski-collection/mp4_480p"
        assert(testVideoItemURL == testVideoItem.getVideoUrl())
    }

}
