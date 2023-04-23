import Foundation

protocol ValueInformation {
    var title: String { get }
    var unitMeasure: String { get }
    var limit: Double { get }
}

public struct Co2ValueInformation: ValueInformation {
    
    public let title: String = "CO²"
    public let unitMeasure: String = "ppm"
    public let limit: Double = 10000.0
}

public struct VocValueInformation: ValueInformation {
    
    public let title: String = "VOC Index"
    public let unitMeasure: String = ""
    public let limit: Double = 500.0
}

public struct PMValueInformation: ValueInformation {
    
    public let title: String = "PM2.5"
    public let unitMeasure: String = "µg/m³"
    public let limit: Double = 75.1
}

public struct TempCelsiusValueInformation: ValueInformation {
    
    public let title: String = "Temperature"
    public let unitMeasure: String = "°C"
    public let limit: Double = 65.0
}

public struct TempFahrenheitValueInformation: ValueInformation {
    
    public let title: String = "Temperature"
    public let unitMeasure: String = "°F"
    public let limit: Double = 149.0

}

public struct HumidityValueInformation: ValueInformation {
    
    public let title: String = "Humidity"
    public let unitMeasure: String = "%"
    public let limit: Double = 100.0
}

