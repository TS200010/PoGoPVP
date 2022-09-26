//
//  RepoTests.swift
//  PoGoPVPTests
//
//  Created by Anthony Stanners on 25/09/2022.
//

import XCTest
@testable import PoGoPVP

final class RepoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEffect()->Void{
        var a:Effect?
        var s="No Effect"
        a = s.effectFromString()
        XCTAssert( a == .noEffect )
        XCTAssert( a?.stringFromEffect( ) == s)
        
        s = "Not Very Effective"
        a = s.effectFromString()
        XCTAssert( a == .notVeryEffective )
        XCTAssert( a?.stringFromEffect( ) == s)
        
        s = "Normal Effect"
        a = s.effectFromString()
        XCTAssert( a == .normalEffect )
        XCTAssert( a?.stringFromEffect( ) == s)
        
        s = "Super Effective"
        a = s.effectFromString()
        XCTAssert( a == .superEffective )
        XCTAssert( a?.stringFromEffect( ) == s)
        
        s="NoEffect"
        a = s.effectFromString()
        XCTAssert( a == .noEffect )
        XCTAssert( a?.stringFromEffect( ) != s)
        
        s = "NotVeryEffective"
        a = s.effectFromString()
        XCTAssert( a == .notVeryEffective )
        XCTAssert( a?.stringFromEffect( ) != s)
        
        s = "NormalEffect"
        a = s.effectFromString()
        XCTAssert( a == .normalEffect )
        XCTAssert( a?.stringFromEffect( ) != s)
        
        s = "SuperEffective"
        a = s.effectFromString()
        XCTAssert( a == .superEffective )
        XCTAssert( a?.stringFromEffect( ) != s)
        
    }
    
    func testMonTypes()->Void{
        var s = "Normal"
        var a = s.monTypeFromString()
        XCTAssert( a == .normal )
        XCTAssert( a?.stringFromMonType( ) == s)
        
        s = "Fairy"
        a = s.monTypeFromString()
        XCTAssert( a == .fairy )
        XCTAssert( a?.stringFromMonType( ) == s)
    }

}
