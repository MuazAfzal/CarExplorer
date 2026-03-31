import SwiftUI
import MapKit

struct DealersView: View {
    let postcode: String

    @State private var cameraPosition: MapCameraPosition = .automatic

    let dealers: [Dealer] = [
        Dealer(
            name: "AutoHub",
            city: "Huddersfield",
            postcodeArea: "HD",
            rating: 4.5,
            carsAvailable: 24,
            speciality: "First cars",
            latitude: 53.6458,
            longitude: -1.7850
        ),
        Dealer(
            name: "Budget Cars",
            city: "Leeds",
            postcodeArea: "LS",
            rating: 4.2,
            carsAvailable: 18,
            speciality: "Low-cost cars",
            latitude: 53.8008,
            longitude: -1.5491
        ),
        Dealer(
            name: "DriveSmart",
            city: "Bradford",
            postcodeArea: "BD",
            rating: 4.7,
            carsAvailable: 31,
            speciality: "Reliable hatchbacks",
            latitude: 53.7950,
            longitude: -1.7594
        ),
        Dealer(
            name: "MotorPoint",
            city: "Sheffield",
            postcodeArea: "S",
            rating: 4.4,
            carsAvailable: 27,
            speciality: "Used family cars",
            latitude: 53.3811,
            longitude: -1.4701
        ),
        Dealer(
            name: "First Drive Cars",
            city: "Wakefield",
            postcodeArea: "WF",
            rating: 4.6,
            carsAvailable: 15,
            speciality: "Starter cars",
            latitude: 53.6833,
            longitude: -1.4977
        ),
        Dealer(
            name: "City Motors",
            city: "Manchester",
            postcodeArea: "M",
            rating: 4.3,
            carsAvailable: 20,
            speciality: "Affordable used cars",
            latitude: 53.4808,
            longitude: -2.2426
        )
    ]

    var cleanedPostcodeArea: String {
        let trimmed = postcode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let letters = trimmed.prefix { $0.isLetter }
        return String(letters)
    }

    func distanceScore(for dealer: Dealer) -> Int {
        if cleanedPostcodeArea.isEmpty { return 99 }
        if dealer.postcodeArea == cleanedPostcodeArea { return 0 }

        let nearbyMap: [String: [String]] = [
            "HD": ["BD", "LS", "WF"],
            "LS": ["HD", "BD", "WF"],
            "BD": ["HD", "LS", "WF"],
            "WF": ["HD", "LS", "BD"],
            "S": ["WF", "LS"],
            "M": ["HD", "LS"]
        ]

        if nearbyMap[cleanedPostcodeArea]?.contains(dealer.postcodeArea) == true {
            return 1
        }

        return 2
    }

    func distanceText(for dealer: Dealer) -> String {
        switch distanceScore(for: dealer) {
        case 0:
            return "Closest match"
        case 1:
            return "Nearby area"
        default:
            return "Farther away"
        }
    }

    var sortedDealers: [Dealer] {
        dealers.sorted {
            let firstScore = distanceScore(for: $0)
            let secondScore = distanceScore(for: $1)

            if firstScore == secondScore {
                return $0.rating > $1.rating
            }
            return firstScore < secondScore
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.10),
                    Color.white,
                    Color(.systemGroupedBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Nearby Dealers")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        if cleanedPostcodeArea.isEmpty {
                            Text("Showing all dealers. Search from the Home tab with a postcode to rank the nearest ones.")
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Results ranked for postcode area \(cleanedPostcodeArea).")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal)

                    Map(position: $cameraPosition) {
                        ForEach(sortedDealers) { dealer in
                            Annotation(dealer.name, coordinate: dealer.coordinate) {
                                VStack(spacing: 4) {
                                    Image(systemName: distanceScore(for: dealer) == 0 ? "mappin.circle.fill" : "car.circle.fill")
                                        .font(.title)
                                        .foregroundStyle(distanceScore(for: dealer) == 0 ? .green : .blue)

                                    Text(dealer.name)
                                        .font(.caption2)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 4)
                                        .background(.ultraThinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                    }
                    .frame(height: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.horizontal)
                    .onAppear {
                        if let firstDealer = sortedDealers.first {
                            cameraPosition = .region(
                                MKCoordinateRegion(
                                    center: firstDealer.coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
                                )
                            )
                        }
                    }

                    ForEach(sortedDealers) { dealer in
                        DealerCard(
                            dealer: dealer,
                            distanceLabel: distanceText(for: dealer),
                            isBestMatch: distanceScore(for: dealer) == 0
                        )
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Dealers")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DealerCard: View {
    let dealer: Dealer
    let distanceLabel: String
    let isBestMatch: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(dealer.name)
                        .font(.headline)

                    Text(dealer.city)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isBestMatch {
                    Label("Nearest", systemImage: "location.fill")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.green.opacity(0.14))
                        .foregroundStyle(.green)
                        .clipShape(Capsule())
                }
            }

            HStack {
                Label(distanceLabel, systemImage: "mappin.and.ellipse")
                Spacer()
                Label(String(format: "%.1f", dealer.rating), systemImage: "star.fill")
                Spacer()
                Label("\(dealer.carsAvailable) cars", systemImage: "car.2.fill")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                Image(systemName: "checkmark.seal")
                    .foregroundStyle(.blue)

                Text(dealer.speciality)
                    .font(.subheadline)
            }

            Button(action: {}) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Contact Dealer")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        DealersView(postcode: "HD1")
    }
}
