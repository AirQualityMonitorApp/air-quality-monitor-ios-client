import Foundation

protocol ValueInformation {
    var title: String { get }
    var unitMeasure: String { get }
    var limit: Double { get }
    var popupMessage: String { get }
    var informationImage: String { get }
    var informationMessage: String { get }
}

public struct Co2ValueInformation: ValueInformation {
    
    public let title: String = "CO²"
    public let unitMeasure: String = "ppm"
    public let limit: Double = 5000.0
    public let popupMessage: String = "CO² value is too high! Ventilate your room."
    public let informationImage: String = "warning"
    public let informationMessage: String = "CO²"
    
}

public struct VocValueInformation: ValueInformation {
    
    public let title: String = "VOC Index"
    public let unitMeasure: String = ""
    public let limit: Double = 500.0
    public let popupMessage: String = "VOC value is too high! Ventilate your room."
    public let informationImage: String = "warning"
    public let informationMessage: String = ""
}

public struct PMValueInformation: ValueInformation {
    
    public let title: String = "PM2.5"
    public let unitMeasure: String = "µg/m³"
    public let limit: Double = 75.1
    public let popupMessage: String = "PM is too high! Ventilate your room."
    public let informationImage: String = "warning"
    public let informationMessage: String = ""
}

public struct TempCelsiusValueInformation: ValueInformation {
    
    public let title: String = "Temperature"
    public let unitMeasure: String = "°C"
    public let limit: Double = 65.0
    public let popupMessage: String = "Temperature is too high! Ventilate your room."
    public let informationImage: String = "warning"
    public let informationMessage: String = ""
}

public struct TempFahrenheitValueInformation: ValueInformation {
    
    public let title: String = "Temperature"
    public let unitMeasure: String = "°F"
    public let limit: Double = 149.0
    public let popupMessage: String = "Temperature is too high! Ventilate your room."
    public let informationImage: String = "warning"
    public let informationMessage: String = ""

}

public struct HumidityValueInformation: ValueInformation {
    
    public let title: String = "Humidity"
    public let unitMeasure: String = "%"
    public let limit: Double = 100.0
    public let popupMessage: String = "Humidity is too high! Ventilate your room."
    public let informationImage: String = "warning"
    public let informationMessage: String = ""
}

