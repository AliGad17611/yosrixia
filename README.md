# Yosrixia - Arabic Learning App for Dyslexic Children

Yosrixia is a comprehensive Flutter-based educational application designed specifically for children with dyslexia to learn Arabic language through interactive lessons, games, and AI-powered features. The app provides a multi-role platform supporting children, parents, and doctors with specialized tools for learning, monitoring, and treatment.

## 🌟 Features

### For Children
- **Interactive Arabic Lessons**: Learn Arabic letters, words, and sentences through engaging tutorials
- **Educational Games**: Multiple game types including puzzles, handwriting recognition, character matching, and word completion
- **Speech Recognition**: AI-powered Arabic speech-to-text for pronunciation practice
- **Handwriting Recognition**: Google ML Kit integration for Arabic handwriting practice
- **Stories & Audio**: Interactive storytelling with audio narration
- **Chat System**: AI-powered chat assistance for learning support
- **Progress Tracking**: Visual progress indicators and achievements

### For Parents/Guardians
- **Child Monitoring**: Track child's learning progress and performance
- **Doctor Consultation**: Connect with specialized doctors for dyslexia treatment
- **Subscription Management**: Flexible payment options with Paymob integration
- **Profile Management**: Manage child profiles and learning preferences

### For Doctors
- **Patient Management**: Monitor multiple children's progress
- **Assessment Tools**: Specialized dyslexia assessment questionnaires
- **Treatment Tracking**: Track treatment effectiveness and progress
- **Communication**: Direct communication with parents and children

## 🏗️ Architecture

### Technology Stack

```mermaid
graph TB
    subgraph "Frontend"
        Flutter[Flutter 3.5.4+]
        Dart[Dart SDK]
        UI[Material Design UI]
    end
    
    subgraph "State Management"
        Bloc[Flutter BLoC Pattern]
        Cubit[Cubit State Management]
        Equatable[Equatable for State Comparison]
    end
    
    subgraph "Backend Services"
        Firebase[Firebase Suite]
        Supabase[Supabase]
        MLKit[Google ML Kit]
        Paymob[Paymob Payment]
    end
    
    subgraph "Local Storage"
        Hive[Hive Database]
        SharedPrefs[Shared Preferences]
    end
    
    Flutter --> Bloc
    Flutter --> Firebase
    Flutter --> Supabase
    Flutter --> MLKit
    Flutter --> Paymob
    Flutter --> Hive
    Bloc --> Cubit
```

### Project Structure

```
lib/
├── core/                          # Core functionality and shared resources
│   ├── cubit/                     # Global state management
│   ├── database/                  # Firebase services
│   ├── helper/                    # Utility functions and helpers
│   ├── models/                    # Data models
│   ├── services/                  # External service integrations
│   ├── utils/                     # Constants, styles, routing
│   └── widgets/                   # Reusable UI components
├── features/                      # Feature-based modules
│   ├── auth/                      # Authentication system
│   ├── child/                     # Child-specific features
│   │   ├── chat/                  # AI chat system
│   │   ├── dross/                 # Learning lessons
│   │   │   ├── gomal/            # Sentence lessons
│   │   │   ├── stories/          # Interactive stories
│   │   │   └── words/            # Letter and word lessons
│   │   ├── games/                 # Educational games
│   │   │   ├── find_character_game/
│   │   │   ├── handwriting/
│   │   │   ├── identical_character/
│   │   │   └── puzzel/
│   │   ├── profile/               # Child profile management
│   │   └── tips/                  # Learning tips
│   ├── doctor/                    # Doctor dashboard
│   ├── onboarding/                # App onboarding
│   ├── settings/                  # App settings
│   └── subscripton_and_payments/  # Payment system
└── main.dart                      # App entry point
```

## 🔄 Data Flow Architecture

### User Authentication Flow

```mermaid
sequenceDiagram
    participant User
    participant App
    participant Firebase
    participant Firestore
    
    User->>App: Launch App
    App->>Firebase: Check Auth Status
    
    alt User Not Authenticated
        App->>User: Show Welcome Screen
        User->>App: Select Role (Child/Parent/Doctor)
        User->>App: Register/Login
        App->>Firebase: Authenticate User
        Firebase-->>App: Auth Token
        App->>Firestore: Create/Update User Profile
    else User Authenticated
        App->>Firestore: Fetch User Data
        Firestore-->>App: User Profile
        App->>User: Navigate to Role-Based Home
    end
```

### Learning Content Flow

```mermaid
flowchart TD
    A[Child Home] --> B{Select Learning Type}
    B --> C[Letters & Words]
    B --> D[Sentences]
    B --> E[Stories]
    B --> F[Games]
    
    C --> G[Character Selection]
    G --> H[Sub-Character Learning]
    H --> I[Speech Recognition Practice]
    H --> J[Handwriting Practice]
    
    D --> K[Sentence Structure]
    K --> L[Audio Narration]
    
    E --> M[Interactive Stories]
    M --> N[Text-to-Speech]
    M --> O[Comprehension Check]
    
    F --> P[Puzzle Games]
    F --> Q[Character Matching]
    F --> R[Word Completion]
    F --> S[Find Character]
    
    I --> T[Progress Tracking]
    J --> T
    L --> T
    O --> T
    P --> T
    Q --> T
    R --> T
    S --> T
```

### State Management Flow

```mermaid
graph LR
    subgraph "UI Layer"
        Widget[Flutter Widgets]
        BlocBuilder[BlocBuilder]
        BlocListener[BlocListener]
    end
    
    subgraph "Business Logic"
        Cubit[Cubit]
        State[State Classes]
        Event[Events/Methods]
    end
    
    subgraph "Data Layer"
        Repository[Repository]
        Firebase[Firebase Services]
        LocalDB[Hive Storage]
        API[External APIs]
    end
    
    Widget --> BlocBuilder
    BlocBuilder --> Cubit
    Widget --> Event
    Event --> Cubit
    Cubit --> State
    State --> BlocListener
    BlocListener --> Widget
    
    Cubit --> Repository
    Repository --> Firebase
    Repository --> LocalDB
    Repository --> API
```

## 🎮 Game Systems Architecture

### Handwriting Recognition System

```mermaid
sequenceDiagram
    participant Child
    participant UI
    participant HandwritingCubit
    participant MLKit
    participant AudioPlayer
    
    Child->>UI: Draw Arabic Character
    UI->>HandwritingCubit: Process Ink Strokes
    HandwritingCubit->>MLKit: Recognize Arabic Text
    MLKit-->>HandwritingCubit: Recognition Result
    
    alt Character Matches Target
        HandwritingCubit->>AudioPlayer: Play Success Sound
        HandwritingCubit->>UI: Show Success Animation
    else Character Doesn't Match
        HandwritingCubit->>AudioPlayer: Play Try Again Sound
        HandwritingCubit->>UI: Show Hint
    end
    
    HandwritingCubit->>UI: Update Progress
```

### Speech Recognition Flow

```mermaid
flowchart TD
    A[Start Speech Exercise] --> B[Display Target Word/Letter]
    B --> C[Child Speaks]
    C --> D[Speech-to-Text Processing]
    D --> E{Text Matches Target?}
    
    E -->|Yes| F[Play Success Sound]
    E -->|No| G[Play Encouragement Sound]
    
    F --> H[Update Progress]
    G --> I[Show Visual Hint]
    I --> J[Allow Retry]
    J --> C
    H --> K[Next Exercise]
```

## 💳 Payment System Architecture

```mermaid
sequenceDiagram
    participant Parent
    participant App
    participant PaymentService
    participant Paymob
    participant SubscriptionService
    participant Firestore
    
    Parent->>App: Select Subscription Plan
    App->>PaymentService: Initialize Payment
    PaymentService->>Paymob: Create Payment Intent
    Paymob-->>PaymentService: Payment Token
    
    PaymentService->>Parent: Show Payment Interface
    Parent->>Paymob: Complete Payment
    Paymob-->>PaymentService: Payment Result
    
    alt Payment Successful
        PaymentService->>SubscriptionService: Create Subscription
        SubscriptionService->>Firestore: Store Subscription Data
        PaymentService->>App: Show Success Message
    else Payment Failed
        PaymentService->>App: Show Error Message
    end
```

## 🗄️ Database Schema

### Firebase Firestore Collections

```mermaid
erDiagram
    USERS {
        string uid PK
        string name
        string email
        string role
        string imageUrl
        timestamp createdAt
        map personalInfo
    }
    
    SUBSCRIPTIONS {
        string userId FK
        timestamp startDate
        timestamp expiryDate
        string type
        boolean isActive
    }
    
    PROGRESS {
        string userId FK
        string lessonId
        int score
        timestamp completedAt
        map details
    }
    
    CHAT_MESSAGES {
        string userId FK
        string message
        string response
        timestamp createdAt
    }
    
    USERS ||--o{ SUBSCRIPTIONS : has
    USERS ||--o{ PROGRESS : tracks
    USERS ||--o{ CHAT_MESSAGES : sends
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.5.4 or higher
- Dart SDK
- Android Studio / VS Code
- Firebase account
- Supabase account
- Paymob merchant account

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/yosrixia.git
   cd yosrixia
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a new Firebase project
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Update `firebase_options.dart` with your configuration

4. **Configure Supabase**
   - Update `supabase_config.dart` with your Supabase URL and anon key

5. **Configure Paymob**
   - Update payment credentials in `payment_services.dart`

6. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (11.0+)
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔧 Key Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management |
| `firebase_core` | Firebase integration |
| `cloud_firestore` | Database |
| `firebase_auth` | Authentication |
| `supabase_flutter` | Additional backend services |
| `google_mlkit_digital_ink_recognition` | Handwriting recognition |
| `speech_to_text` | Arabic speech recognition |
| `audioplayers` | Audio playback |
| `flutter_paymob` | Payment processing |
| `go_router` | Navigation |
| `hive` | Local storage |
| `flutter_screenutil` | Responsive design |

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Support

For support, email support@yosrixia.com or join our Discord community.

## 🙏 Acknowledgments

- Google ML Kit team for Arabic handwriting recognition
- Flutter team for the amazing framework
- Firebase team for backend services
- All contributors and testers who helped make this app better

---

Made with ❤️ for children with dyslexia to learn Arabic effectively.