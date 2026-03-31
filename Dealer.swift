import Foundation
import CoreLocation

struct Dealer: Identifiable {
    let id = UUID()
    let name: String
    let city: String
    let postcodeArea: String
    let rating: Double
    let carsAvailable: Int
    let speciality: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
