import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.88
    @State private var opacity: Double = 0.5

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.18),
                    Color.white,
                    Color(.systemGroupedBackground)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 5)
                    .scaleEffect(scale)

                VStack(spacing: 10) {
                    Text("CarExplorer")
                        .font(.system(size: 34, weight: .bold))

                    Text("Find affordable first cars with confidence")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .opacity(opacity)

                VStack(spacing: 12) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.2)

                    Text("Loading...")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .opacity(opacity)

                Spacer()

                Text("Compare listings, explore dealers, and find the right first car.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                    .opacity(opacity)
            }
            .padding()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    SplashView()
}
