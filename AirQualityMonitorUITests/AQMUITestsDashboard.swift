import XCTest

import Foundation

final class AQMUITestsDashboard: XCTestCase {
    
    func testDashboardElements() throws {
        let app = XCUIApplication()
        setDashboardSettingsToDefault(app: app)
        app.launch()
        
        // Check if all the values titles are present
        XCTAssertEqual(app.buttons["Temperature"].exists, true)
        XCTAssertEqual(app.buttons["Humidity"].exists, true)
        XCTAssertEqual(app.buttons["CO²"].exists, true)
        XCTAssertEqual(app.buttons["VOC Index"].exists, true)
        XCTAssertEqual(app.buttons["PM2.5"].exists, true)
        
        //Check for the tabbar and click on "settings"
        XCTAssert(app.tabBars.element.exists, "Tab bar does not exist.")
        app.buttons["Settings"].tap()
        
        XCTAssertEqual(app.staticTexts["DASHBOARD SETTINGS"].exists, true)
        
        // Go back to the Dashboard
        app.buttons["Dashboard"].tap()
    }
    
    func testDashboardWithourWeatherValues() {
        let app = XCUIApplication()
        setDashboardSettingsToDefault(app: app)
        app.launch()
        
        // Check for the tabbar and click on "Settings"
        XCTAssert(app.tabBars.element.exists, "Tab bar does not exist.")
        app.buttons["Settings"].tap()
        
        //Check if "Hide weather values" exists and enable the toggle
        XCTAssertEqual(app.staticTexts["Hide weather values"].exists, true)
        let weatherValuesToggle = app.switches["Hide weather values"]
        weatherValuesToggle.tap()
        let toggleValue = weatherValuesToggle.value as? String
        XCTAssertEqual(toggleValue, "1")
        
        // Go back to the dashboard and check if the weather values are not present
        app.buttons["Dashboard"].tap()
        XCTAssertEqual(app.buttons["Temperature"].exists, false)
        XCTAssertEqual(app.buttons["Humidity"].exists, false)
    }
    
    func testDashboardWithourGasPmValues() {
        let app = XCUIApplication()
        setDashboardSettingsToDefault(app: app)
        app.launch()
        
        // Check for the tabbar and click on "Settings"
        XCTAssert(app.tabBars.element.exists, "Tab bar does not exist.")
        app.buttons["Settings"].tap()
        
        //Check if "Hide VOC, CO² and PM2.5" exists and enable the toggle
        XCTAssertEqual(app.staticTexts["Hide VOC, CO² and PM2.5"].exists, true)
        let weatherValuesToggle = app.switches["Hide VOC, CO² and PM2.5"]
        weatherValuesToggle.tap()
        let toggleValue = weatherValuesToggle.value as? String
        XCTAssertEqual(toggleValue, "1")
        
        // Go back to the dashboard and check if the weather values are not present
        app.buttons["Dashboard"].tap()
        XCTAssertEqual(app.buttons["VOC"].exists, false)
        XCTAssertEqual(app.buttons["CO²"].exists, false)
        XCTAssertEqual(app.buttons["PM2.5"].exists, false)
    }
}

private extension AQMUITestsDashboard {
    private func setDashboardSettingsToDefault(app: XCUIApplication) {
        app.launchArguments += ["-isFahrenheit", "NO", "-weatherValuesAreHidden", "NO", "-gasPmValuesAreHidden", "NO"]
    }
}
