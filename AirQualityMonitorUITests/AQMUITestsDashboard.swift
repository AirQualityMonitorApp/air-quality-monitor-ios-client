import XCTest

import Foundation

final class SBTUITestsDashboard: XCTestCase {
    
    func testDashboardElements() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.buttons["Temperature"].exists, true)
        XCTAssertEqual(app.buttons["Humidity"].exists, true)
        XCTAssertEqual(app.buttons["CO²"].exists, true)
        XCTAssertEqual(app.buttons["VOC Index"].exists, true)
        XCTAssertEqual(app.buttons["PM2.5"].exists, true)
        
        
        XCTAssert(app.tabBars.element.exists, "Tab bar does not exist.")
        
        app.buttons["Settings"].tap()
        
        XCTAssertEqual(app.staticTexts["DASHBOARD SETTINGS"].exists, true)
        
        app.buttons["Dashboard"].tap()
    }
}
