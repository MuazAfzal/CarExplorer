import SwiftUI

struct ResultsView: View {
    let cars: [Car]

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    if cars.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "car.circle")
                                .font(.system(size: 52))
                                .foregroundStyle(.gray)

                            Text("No cars found")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("Try changing your filters and search again.")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 80)
                    } else {
                        ForEach(cars) { car in
                            NavigationLink(destination: CarDetailView(car: car)) {
                                ResultCarCard(car: car)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Results")
    }
}

struct ResultCarCard: View {
    let car: Car

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack(alignment: .topLeading) {
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
                                .font(.largeTitle)
                                .foregroundStyle(.blue)
                        }
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .clipped()

                Text(car.dealLabel)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .padding(12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 22))

            VStack(alignment: .leading, spacing: 8) {
                Text(car.name)
                    .font(.headline)

                Text("£\(car.price)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)

                HStack {
                    Label("\(car.year)", systemImage: "calendar")
                    Spacer()
                    Label("\(car.mileage.formatted()) mi", systemImage: "speedometer")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                HStack {
                    Text(car.fuel)
                    Spacer()
                    Text(car.transmission)
                    Spacer()
                    Text(car.location)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 4)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack {
        ResultsView(cars: [
            Car(
                id: UUID().uuidString,
                name: "Ford Fiesta Zetec",
                price: 2500,
                mileage: 70000,
                year: 2014,
                fuel: "Petrol",
                transmission: "Manual",
                location: "Huddersfield",
                dealer: "AutoHub",
                imageURL: "https://images.unsplash.com/photo-1494976388531-d1058494cdd8",
                source: "Local",
                listingURL: ""
            )
        ])
    }
}
