# 🚗 CarExplorer – iOS App

CarExplorer is an iOS application designed to help new drivers find their first car easily and affordably. It brings together car discovery, filtering, and nearby dealer search into one clean, user-friendly interface.

The goal of this project was to build a modern, real-world mobile app using SwiftUI, while focusing on usability, clean UI design, and practical features that solve an actual problem.

---

## 📱 Features

### 🔍 Smart Car Search
- Search cars by name, location, or dealer
- Real-time filtering of results
- Clean and responsive search interface

### 💰 Budget Filtering
- Quick budget options (e.g. Under £2500, £3500)
- Advanced filtering with:
  - Price
  - Fuel type
  - Transmission

### 🚘 Featured Cars
- Displays curated car listings
- Shows:
  - Price
  - Mileage
  - Year
  - Location
- Includes a **“Best Deal” scoring system** based on:
  - Price
  - Mileage
  - Age

### 📍 Nearby Dealers
- Users can enter postcode
- Finds nearby dealers (UI + logic ready)
- Designed to integrate with maps

### 🗺 Map Integration
- Dealer locations displayed on a map
- Uses Apple MapKit

### ❤️ Save Cars
- Users can bookmark cars
- Saved cars accessible from tab bar

### 🔐 Login System
- Simple authentication system

Demo account:
```
Email: user@example.com  
Password: pass123
```

### ⚙️ Settings
- Light / Dark mode toggle
- User preferences

### 🧠 Siri Integration (App Intents)
- Example command:
  - “Find nearby dealers”

### 🚀 Splash Screen
- Custom loading screen on app launch

---

## 🧱 Tech Stack

- **Language:** Swift  
- **Framework:** SwiftUI  
- **Architecture:** MVVM-style (lightweight)  
- **UI:** Native SwiftUI components  
- **Maps:** MapKit  
- **State Management:** @State, @Binding  
- **Image Loading:** AsyncImage  

---

## 📂 Project Structure

```
CarExplorer/
│
├── Models/
│   ├── Car.swift
│   └── Dealer.swift
│
├── Views/
│   ├── HomeView.swift
│   ├── SearchView.swift
│   ├── ResultsView.swift
│   ├── CarDetailView.swift
│   ├── DealersView.swift
│   ├── SavedView.swift
│   ├── SettingsView.swift
│   ├── LoginView.swift
│   └── SplashView.swift
│
├── Navigation/
│   └── AppNavigation.swift
│
├── Intents/
│   ├── FindNearbyDealersIntent.swift
│   └── CarExplorerShortcuts.swift
│
├── Assets/
│   ├── AppIcon
│   └── logo
│
└── CarExplorerApp.swift
```

---

## 🧠 Core Logic

### Deal Scoring System

Each car is scored based on:

- Lower price → higher score  
- Lower mileage → higher score  
- Newer year → higher score  

This generates labels like:
- **Best Deal**
- **Great Value**
- **Good Option**

---

## 🎨 UI/UX Design

The design focuses on:

- Clean and minimal layout  
- Clear hierarchy  
- Card-based UI for readability  
- Consistent spacing and alignment  
- Mobile-first interaction design  

---

## 🚀 How to Run the Project

### Requirements
- macOS  
- Xcode (latest version recommended)  
- iOS Simulator or real device  

### Steps

1. Clone the repository:
```bash
git clone https://github.com/yourusername/car-explorer.git
```

2. Open the project in Xcode:
```
CarExplorer.xcodeproj
```

3. Run the app:
- Select a simulator (e.g. iPhone 17 Pro)
- Press **Cmd + R**

---

## 🔮 Future Improvements

- Real API integration (AutoTrader, eBay, etc.)
- Live car listings instead of static data
- Backend integration (Node.js / Firebase)
- Real postcode → GPS conversion
- Notifications for new listings
- AI-based recommendations
- Proper authentication system

---

## 📚 What I Learned

- Building a full iOS app using SwiftUI  
- Structuring a multi-screen project  
- Managing state across views  
- Designing clean mobile UI  
- Integrating MapKit and App Intents  
- Debugging real-world Xcode issues  

---

## 🎯 Why This Project Matters

This project demonstrates:

- Strong SwiftUI development skills  
- Real-world problem solving  
- Mobile UI/UX design understanding  
- Ability to build scalable applications  

---

## 👤 Author

**Muaz Afzal**  
BSc Computer Science  
University of Huddersfield  

---

## 📄 License

This project is for educational and portfolio use.

---

## 💬 Final Note

This project is built to resemble a real-world product rather than a basic demo.  
The focus is on usability, clean design, and practical features.
