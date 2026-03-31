import SwiftUI

struct SavedView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "heart.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.red)

                Text("No saved cars yet")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Cars you save will appear here.")
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("Saved Cars")
    }
}

#Preview {
    NavigationStack {
        SavedView()
    }
}
