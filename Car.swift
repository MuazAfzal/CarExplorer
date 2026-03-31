import Foundation

struct Car: Identifiable, Codable {
    let id: String
    let name: String
    let price: Int
    let mileage: Int
    let year: Int
    let fuel: String
    let transmission: String
    let location: String
    let dealer: String
    let imageURL: String
    let source: String
    let listingURL: String

    var bestDealScore: Int {
        let ageScore = max(0, year - 2010) * 8
        let mileageScore = max(0, 120000 - mileage) / 2000
        let priceScore = max(0, 5000 - price) / 100
        return ageScore + mileageScore + priceScore
    }

    var dealLabel: String {
        if bestDealScore >= 45 {
            return "Best Deal"
        } else if bestDealScore >= 35 {
            return "Great Value"
        } else {
            return "Good Option"
        }
    }
}
