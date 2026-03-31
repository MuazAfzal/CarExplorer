import SwiftUI

struct CarDetailView: View {
    let car: Car

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: car.imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        ZStack {
                            Color.blue.opacity(0.12)
                            Image(systemName: "car.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(.blue)
                        }
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 24))

                VStack(alignment: .leading, spacing: 10) {
                    Text(car.name)
                        .font(.system(size: 30, weight: .bold))

                    Text("£\(car.price)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.blue)

                    Text(car.dealLabel)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.12))
                        .clipShape(Capsule())
                }

                VStack(alignment: .leading, spacing: 14) {
                    DetailRow(title: "Year", value: "\(car.year)")
                    DetailRow(title: "Mileage", value: "\(car.mileage.formatted()) miles")
                    DetailRow(title: "Fuel", value: car.fuel)
                    DetailRow(title: "Transmission", value: car.transmission)
                    DetailRow(title: "Location", value: car.location)
                    DetailRow(title: "Dealer", value: car.dealer)
                    DetailRow(title: "Source", value: car.source)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Why this is recommended")
                        .font(.headline)

                    Text("This car is a strong option for a first-time driver because it offers a fair price, sensible mileage, and good everyday usability.")
                        .foregroundStyle(.secondary)
                }

                Button(action: {}) {
                    Text("Save Car")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                if let url = URL(string: car.listingURL), !car.listingURL.isEmpty {
                    Link(destination: url) {
                        HStack {
                            Image(systemName: "arrow.up.right.square")
                            Text("View Original Listing")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.25), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Car Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationStack {
        CarDetailView(
            car: Car(
                id: UUID().uuidString,
                name: "Toyota Yaris Icon",
                price: 3500,
                mileage: 60000,
                year: 2016,
                fuel: "Hybrid",
                transmission: "Automatic",
                location: "Bradford",
                dealer: "DriveSmart",
                imageURL: "https://images.unsplash.com/photo-1503376780353-7e6692767b70",
                source: "Local",
                listingURL: ""
            )
        )
    }
}
