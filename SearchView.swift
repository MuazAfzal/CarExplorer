import SwiftUI

struct SearchView: View {
    @State private var maxPrice: String = ""
    @State private var fuelType: String = "Any"
    @State private var transmission: String = "Any"

    let fuelOptions = ["Any", "Petrol", "Diesel", "Hybrid", "Electric"]
    let transmissionOptions = ["Any", "Manual", "Automatic"]

    let allCars: [Car] = [
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
        ),
        Car(
            id: UUID().uuidString,
            name: "Vauxhall Corsa SE",
            price: 2200,
            mileage: 80000,
            year: 2013,
            fuel: "Petrol",
            transmission: "Manual",
            location: "Leeds",
            dealer: "Budget Cars",
            imageURL: "https://images.unsplash.com/photo-1502877338535-766e1452684a",
            source: "Local",
            listingURL: ""
        ),
        Car(
            id: UUID().uuidString,
            name: "VW Polo Match",
            price: 3200,
            mileage: 65000,
            year: 2015,
            fuel: "Diesel",
            transmission: "Manual",
            location: "Manchester",
            dealer: "City Motors",
            imageURL: "https://images.unsplash.com/photo-1541899481282-d53bffe3c35d",
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
            name: "Hyundai i10 Premium",
            price: 2800,
            mileage: 55000,
            year: 2015,
            fuel: "Petrol",
            transmission: "Manual",
            location: "Sheffield",
            dealer: "MotorPoint",
            imageURL: "https://images.unsplash.com/photo-1552519507-da3b142c6e3d",
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
        ),
        Car(
            id: UUID().uuidString,
            name: "Renault Clio Play",
            price: 3400,
            mileage: 62000,
            year: 2017,
            fuel: "Diesel",
            transmission: "Manual",
            location: "Huddersfield",
            dealer: "North Cars",
            imageURL: "https://images.unsplash.com/photo-1511919884226-fd3cad34687c",
            source: "Local",
            listingURL: ""
        )
    ]

    var filteredCars: [Car] {
        allCars
            .filter { car in
                let matchesPrice = maxPrice.isEmpty || car.price <= (Int(maxPrice) ?? Int.max)
                let matchesFuel = fuelType == "Any" || car.fuel == fuelType
                let matchesTransmission = transmission == "Any" || car.transmission == transmission
                return matchesPrice && matchesFuel && matchesTransmission
            }
            .sorted { $0.bestDealScore > $1.bestDealScore }
    }

    var body: some View {
        Form {
            Section("Budget") {
                TextField("Max Price (£)", text: $maxPrice)
                    .keyboardType(.numberPad)
            }

            Section("Fuel Type") {
                Picker("Fuel", selection: $fuelType) {
                    ForEach(fuelOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.menu)
            }

            Section("Transmission") {
                Picker("Transmission", selection: $transmission) {
                    ForEach(transmissionOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(.menu)
            }

            Section {
                NavigationLink(destination: ResultsView(cars: filteredCars)) {
                    Text("Show Results")
                        .fontWeight(.semibold)
                }
            }
        }
        .navigationTitle("Advanced Search")
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
