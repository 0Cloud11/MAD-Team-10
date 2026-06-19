## Project Objective
  This project is an app for students, where they can find courses on AI tools or essential skills, and can also find news on these AI models.

## Project Vision
  Clean and Slick UI that is still easy to navigate and use for anyone.

## Navigation flow
  Login page < - > Sign up page <-> Home Screen <-> Program Listing <-> Program Details <-> Profile/Settings

## Links
  Here are the links to Documents (Google Docs), Wireframes(Figma), and our Repository (GitHub):-

    Documents (Google Docs):-

      Team Charter:		https://docs.google.com/document/d/1lLF50O7wYWmP6jm1J4IVdEzwUwkKl7glbSfSo-8WfNg/edit?usp=sharing

      App Proposal:		https://docs.google.com/document/d/1GflEMeTm0yuZW-8igsAJZOc7CTsPdgmG88C7VsFxF2I/edit?usp=sharing

    Wireframes(Figma):	https://www.figma.com/design/HYcJIbpcJ9kRh3RT8ktdcw/MAD_Team10_Wireframs?node-id=2-3&t=zQYRFB0t0V9swEaL-1

    Repository (GitHub):	https://github.com/0Cloud11/MAD-Team-10


## Week 1 Update
  Initial project setup completed.
  Wireframing and Figma Mock-up created

  ## Screenshots

  <img width="501" height="792" alt="image" src="https://github.com/user-attachments/assets/322b20f9-7fa7-4928-ad57-2f0d2cf5ad48" />

  <img width="433" height="762" alt="image" src="https://github.com/user-attachments/assets/bf28d065-35db-44dd-9a1e-aff72fba060b" />

  <img width="400" height="789" alt="image" src="https://github.com/user-attachments/assets/6fc6db3e-1093-4824-8422-65ff4267c973" />

  <img width="410" height="782" alt="image" src="https://github.com/user-attachments/assets/da57ffa8-35a9-4b8d-8003-a626365ca655" />

  <img width="419" height="773" alt="image" src="https://github.com/user-attachments/assets/6807a543-116a-43b9-9f17-661aa39a7e7c" />


## Week 2 Update

  # AI Course App Prototype
  A fully functional UI prototype built with Flutter.

  ## Implemented Screens
  - **Login Screen**
    - Authenticates users by matching entered username or email and password against locally stored data.
    - Features a show/hide password toggle for improved usability.
    - Supports persistent sessions with a "Keep me signed in" checkbox using local storage.

  - **Sign Up Screen**
    - Captures new user details (username, email, and password).
    - Enforces strict password policies (length limits, casing, numeric, special characters, and no spaces).
    - Provides real-time feedback with a dynamic password strength indicator and actionable suggestions.
    - Persists new user records locally and seamlessly redirects to the Login screen upon success.

  - **Home Screen**
    - Serves as the primary learner dashboard post-login.
    - Greets users with a branded, dynamic welcome banner.
    - Facilitates quick navigation to the Program Listing screen.
    - Clearly outlines the application's primary navigation flow for learners.

  - **Program Listing Screen**
    - Organizes available learning opportunities in a clean, scrollable card-based layout.
    - Integrates a search function, allowing users to filter programs quickly.
    - Implements dynamic rendering logic, ensuring the screen is prepared for future API-fetched collections.
    - Routes users to the Program Details screen upon selecting a specific program card.

  - **Program Details Screen**
    - Presents comprehensive details for the selected program (title, description, start date, schedule, eligibility, instructor, and rating).
    - Dynamically retrieves data via route arguments.
    - Features a placeholder registration action button for future enrollment flows.

  - **Profile Screen**
    - Retrieves and displays locally stored learner profile data.
    - Provides functionality for profile editing.
    - Manages secure logout by clearing the active session state.

  ## Navigation Logic
  - Employs Flutter’s robust navigation system to handle transitions between screens.
  - Utilizes named routes configured in `MaterialApp` for scalable navigation management.
  - Passes complex data (Program objects) dynamically between screens using route arguments.
  - Core learner flow: `Login → Home → Program Listing → Program Details → Back to Program Listing`.
  - Integrates a global bottom navigation bar for immediate access to Home, Programs, and Profile sections.

  ## Theming and Branding
  - Centralizes styling via a global `ThemeData` configuration in `main.dart`.
  - Maintains brand consistency by applying specific primary and secondary color schemes.
  - Unifies UI components using shared styling for inputs (`InputDecorationTheme`), buttons (`ElevatedButtonThemeData`), app bars (`AppBarTheme`), and bottom navigation (`BottomNavigationBarThemeData`).

  ## Data Handling and Persistence
  - Uses `SharedPreferences` to manage lightweight, persistent local data across app sessions.
  - Locally stores user profiles, credentials, skill levels, progress, and session states.
  - Isolates storage logic into a dedicated service file (`user_prefs.dart`) to separate business logic from the UI.

  ## Program Data Structure
  - Encapsulates program data within a dedicated `Program` model.
  - Supports structured object creation, JSON serialization, and deserialization.
  - Ensures the application architecture is fully prepared for backend API integration with minimal refactoring.

  ## Important Flutter Concepts Used
  - **MaterialApp & ThemeData**: Root configuration and global design system management.
  - **Navigator & Routes**: Transition handling and parameter passing via `ModalRoute.of(context).settings.arguments`.
  - **StatefulWidget**: Management of dynamic UI states across core screens.
  - **TextEditingController**: Input capture and validation.
  - **SharedPreferences**: Local data persistence.
  - **ListView.builder**: Efficient, lazy-loaded rendering of dynamic lists.
  - **InputFormatters**: Real-time input restriction (e.g., denying spaces in passwords).

  ## Future Extension Readiness
  - Program views are built to seamlessly transition from hardcoded sample data to API-driven JSON payloads.
  - The `Program` model inherently supports JSON mapping.
  - Data passing between screens handles full objects, aligning with standard backend content consumption.
  - Local storage can be cleanly swapped for REST APIs, Firebase Auth, or cloud databases.

  ## How to Run
  - Ensure Flutter is correctly installed on your machine.
  - Run `flutter pub get` to fetch dependencies.
  - Run `flutter run` to launch the application.

  ## Screenshots

    <img width="367" height="491" alt="image" src="https://github.com/user-attachments/assets/749f9353-3cac-4bbc-87f5-2d81495eb9df" />

    <img width="367" height="472" alt="image" src="https://github.com/user-attachments/assets/953e6077-0cf4-4217-9bec-60c41cf91224" />

    <img width="359" height="500" alt="image" src="https://github.com/user-attachments/assets/88cdd560-b25a-4d29-a5a9-2bb46fb5b178" />

    <img width="355" height="495" alt="image" src="https://github.com/user-attachments/assets/48946ea3-cb20-49af-a757-2cfc3d4b552d" />

    <img width="356" height="491" alt="image" src="https://github.com/user-attachments/assets/e7ce4a09-6d9c-45cf-84f1-79c14277b777" />

    <img width="352" height="489" alt="image" src="https://github.com/user-attachments/assets/d19265ee-0f02-4aed-993e-55526a3a00ba" />

    <img width="349" height="494" alt="image" src="https://github.com/user-attachments/assets/20ed3798-fe3f-4a2a-b6ea-a558f9aff8bc" />

    <img width="347" height="493" alt="image" src="https://github.com/user-attachments/assets/2547d884-1149-423b-9ee8-4281327fae32" />


## Week 3 Update

  # Dynamic State, Mock APIs, and Interactive Forms
  Week 3 transitions the application from a static visual prototype to an interactive, responsive product by introducing asynchronous data fetching, state management, complex form validation, and dynamic UI feedback.

  ## Key Features Implemented

  ### 1. Mock API Integration & Asynchronous Data Fetching
  - Implemented a simulated asynchronous API call (`Program.fetchPrograms()`) inside the `Program` model to mimic backend network requests.
  - Added artificial network latency (`Future.delayed`) to test and observe UI behavior during data retrieval.
  - Updated the **Home Screen** and **Program Listing Screen** to fetch their program collections asynchronously rather than relying on static, instantly available lists.

  ### 2. State Management & Loading Indicators
  - Migrated screens to effectively manage three core states: `Loading`, `Loaded/Success`, and `Error`.
  - Integrated `FutureBuilder` on the Home screen to automatically manage state transitions and render UI based on the `snapshot` connection state.
  - Implemented `setState` logic on the Program Listing screen with boolean flags (`_isLoading`) to display a `CircularProgressIndicator` while data is being fetched.
  - Ensured the UI never feels frozen or unresponsive during data retrieval.

  ### 3. Error Handling and Defensive UI
  - Added robust `try-catch` blocks around asynchronous operations to prevent app crashes on failed network requests.
  - Designed dynamic Error States: If the mock API fails, the UI replaces the loading spinner with a clear error message and a functional "Retry" button, allowing users to re-attempt the fetch without restarting the app.

  ### 4. Interactive Feedback Form
  - Created a brand new **Feedback Screen** accessible via the bottom navigation bar.
  - Implemented a complex `Form` utilizing a `GlobalKey<FormState>` to manage validation.
  - Integrated various input widgets including `TextFormField` (for name, email, and multiline comments) and `DropdownButtonFormField` (for selecting feedback categories).
  - **Validation Logic**: Added regex-based email validation and ensured required fields cannot be submitted empty.
  - **Submission State**: Connected the submit button to a mock asynchronous post request. While submitting, the button displays an internal loading spinner. Upon success, the form dynamically clears itself and triggers a green success `SnackBar`.

  ### 5. Program Registration Flow
  - Replaced the static "Enroll Now" button on the **Program Details Screen** with an interactive registration flow.
  - Implemented a dynamic `showDialog` popup containing a registration form.
  - The dialog captures user intent ("Reason for joining") with field validation, manages its own asynchronous loading state during submission, and dismisses itself upon a simulated successful API post.

  ### 6. Dark Theme Refinement
  - Enhanced the global `ThemeData` to support a cohesive Dark Mode.
  - Implemented a complementary color strategy by introducing a Teal/Cyan (`#06B6D4`) tertiary accent color for dark surfaces, providing high-contrast visual hierarchy opposite the brand's primary Orange (`#FB923C`).

  ## Important Flutter Widgets and Concepts Used
  - **FutureBuilder**: For listening to asynchronous events and building UI reactively based on snapshot states.
  - **CircularProgressIndicator**: For visual user feedback during network latency.
  - **RefreshIndicator**: Added to lists to allow users to manually re-fetch data.
  - **Form & GlobalKey<FormState>**: For grouping input fields and triggering collective validation/reset functions.
  - **DropdownButtonFormField**: For providing constrained, selectable input categories.
  - **showDialog & StatefulBuilder**: For rendering modular, interactive popup overlays that manage their own internal state.
