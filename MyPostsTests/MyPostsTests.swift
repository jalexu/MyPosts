//
//  MyPostsTests.swift
//  MyPostsTests
//
//  Created by Jaime Uribe on 10/11/19.
//  Copyright © 2019 Jaime Uribe. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

enum errorBLPosts : Error {
    case errorResponse
}

class PostsBLFakeNotIsEmpty: PostsBLBehavior {
    
    func getPostOfData(id: Int) throws -> Observable<[ResponseGetData]> {
        var response = [ResponseGetData()]
        response = [ResponseGetData(userId: 101, id: 1, title: "Disfrutar la vida", body: " Yo soy una persona, realmente, muy optimista y muy, muy positiva. Mi meta principal es: ‘disfrutar la vida"), ResponseGetData(userId: 101, id: 2, title: "Sin tí", body: "Puedes llevarte mi alma, porque no la quiero sin ti, ¡Ya es tuya")]
        
        return Observable<[ResponseGetData]>.just(response)
    }
    
    
}

class PostsBLFakeIsEmpty: PostsBLBehavior {
    
    func getPostOfData(id: Int) throws -> Observable<[ResponseGetData]> {
        return Observable.error(errorBLPosts.errorResponse)
    }
    
    
}

@testable import MyPosts
class MyPostsTests: XCTestCase {
    
    var postViewModel: PostsViewModel!
    var scheduler: TestScheduler!
    var disposebag: DisposeBag!

    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposebag = DisposeBag()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
    
    private func createPosts() -> [ResponseGetData]{
        return [ResponseGetData(userId: 101, id: 1, title: "Disfrutar la vida", body: " Yo soy una persona, realmente, muy optimista y muy, muy positiva. Mi meta principal es: ‘disfrutar la vida"), ResponseGetData(userId: 101, id: 2, title: "Sin tí", body: "Puedes llevarte mi alma, porque no la quiero sin ti, ¡Ya es tuya")] 
    }

}
