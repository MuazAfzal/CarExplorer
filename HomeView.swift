import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State private var postcode: String = ""

    let featuredCars: [Car] = [
        Car(
            id: UUID().uuidString,
            name: "Ford Fiesta Zetec",
            price: 2500,
            mileage: 70000,
            year: 2014,
            fuel: "Petrol",
            transmission: "Manual",#imageLiteral(resourceName: "simulator_screenshot_9E192C15-6B27-4D68-948E-0FD0583283F0.png")
            location: "Huddersfield",
            dealer: "AutoHub",
            imageURL: "https://images.unsplash.com/photo-1494976388531-d1058494cdd8",
            source: "Local",
            listingURL: ""
        ),
        Car(
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
        ),
        Car(
            id: UUID().uuidString,
            name: "Kia Picanto 2",
            price: 3000,
            mileage: 50000,
            year: 2016,
            fuel: "Petrol",
            transmission: "Manual",
            location: "Wakefield",
            dealer: "First Drive Cars",
            imageURL: "https://images.unsplash.com/photo-1549924231-f129b911e442",
            source: "Local",
            listingURL: ""
        )
    ]

    var filteredFeaturedCars: [Car] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return featuredCars
        } else {
            return featuredCars.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.location.localizedCaseInsensitiveContains(searchText) ||
                $0.dealer.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.10),
                        Color(.systemBackground),
                        Color(.systemGroupedBackground)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        headerSection
                        
                        searchSection
                        
                        quickBudgetSection
                        
                        exploreSection
                        
                        featuredCarsSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 120)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text("CarExplorer")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Find your first car")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.primary)

            Text("Compare affordable cars, discover better-value options, and find nearby dealers without the stress.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
    }

    private var searchSection: some View {
        VStack(spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField("Search cars, dealer, or location", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
            )

            HStack(spacing: 12) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundStyle(.blue)

                TextField("Enter postcode, e.g. HD1", text: $postcode)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
            }
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
            )
        }
    }

    private var quickBudgetSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Quick Budget")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    BudgetChip(title: "Under £2500", tint: .blue, icon: "sterlingsign.circle.fill")
                    BudgetChip(title: "Under £3500", tint: .green, icon: "tag.fill")
                    BudgetChip(title: "Under £5000", tint: .orange, icon: "banknote.fill")
                    BudgetChip(title: "Automatic", tint: .purple, icon: "gearshape.fill")
                }
                .padding(.horizontal, 2)
            }
        }
    }

    private var exploreSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Explore")

            HStack(spacing: 14) {
                NavigationLink(destination: SearchView()) {
                    CompactFeatureCard(
                        title: "Advanced Search",
                        subtitle: "Budget, fuel and more",
                        icon: "slider.horizontal.3"
                    )
                }
                .buttonStyle(.plain)

                NavigationLink(destination: DealersView(postcode: postcode)) {
                    CompactFeatureCard(
                        title: "Nearby Dealers",
                        subtitle: "Search by postcode",
                        icon: "location.fill"
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var featuredCarsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                sectionTitle("Featured Cars")
                Spacer()
                Text("\(filteredFeaturedCars.count) available")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(filteredFeaturedCars) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            FeaturedCarTile(car: car)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
    }
}

struct BudgetChip: View {
    let title: String
    let tint: Color
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(title)
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(tint)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(tint.opacity(0.12))
        .clipShape(Capsule())
    }
}

struct CompactFeatureCard: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: 46, height: 46)

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.blue)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 145, alignment: .topLeading)
        .background(Color(.systemBackground).opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.05), radius: 12, x: 0, y: 4)
    }
}

struct FeaturedCarTile: View {
    let car: Car

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
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
                            .font(.title)
                            .foregroundStyle(.blue)
                    }
                case .empty:
                    ZStack {
                        Color.gray.opacity(0.08)
                        ProgressView()
                    }
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 250, height: 160)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 22))

            VStack(alignment: .leading, spacing: 6) {
                Text(car.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text("£\(car.price)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)

                Text("\(car.year) • \(car.mileage.formatted()) miles")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack {
                    Text(car.location)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text(car.dealLabel)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(14)
        .frame(width: 282, alignment: .leading)
        .background(Color(.systemBackground).opacity(0.94))
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
    }
}

#Preview {
    HomeView()
}
