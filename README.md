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
  - Login Screen
    - Accepts either username or email together with password validation against locally stored user data.
    - Includes a show/hide password toggle.
    - Includes a “Keep me signed in” checkbox using persistent local storage.

  - Sign Up Screen
    - Captures username, email, and password.
    - Enforces password rules such as minimum and maximum length, uppercase, lowercase, numeric, special character, and no-space requirements.
    - Displays a live password strength indicator and improvement suggestions.
    - Saves the user record locally and redirects the user back to Login after successful registration.

  - Home Screen
    - Acts as the learner dashboard entry point after login.
    - Displays a branded welcome banner.
    - Provides a direct navigation option to the Program Listing screen.
    - Presents the app’s main navigation flow in a clear and learner-friendly manner.

  - Program Listing Screen
    - Displays available programs using a clean card-based layout.
    - Uses a searchable list to help learners quickly locate relevant programs.
    - Uses dynamic rendering logic, making the screen easy to adapt later to API-fetched program collections.
    - Opens the Program Details screen when a user selects a specific program.

  - Program Details Screen
    - Displays detailed information for the selected program.
    - Shows title, description, start date, schedule, eligibility, instructor, and rating.
    - Retrieves the selected program dynamically from route arguments.
    - Includes a registration action button for future extension.

  - Profile Screen
    - Displays locally stored learner profile details.
    - Supports profile editing.
    - Supports logout and clears the active login session state.

  ## Navigation Logic
  - The app uses Flutter’s navigation system to manage transitions across screens.
  - Named routes are defined in the MaterialApp configuration for major screens.
  - The program details flow uses route arguments so that each selected program can be opened dynamically.
  - Current learner journey:
    - Login → Home
    - Home → Program Listing
    - Program Listing → Program Details
    - Program Details → Back to Program Listing
  - The app also includes a bottom navigation bar for quick access to Home, Programs, and Profile.

  ## Theming and Branding
  - A global ThemeData configuration is applied in main.dart.
  - Branding decisions are centralized through:
    - Primary color usage for buttons, highlights, and action emphasis.
    - Secondary color usage for strong dark surfaces and navigation styling.
    - Shared input decoration styling for consistency across authentication screens.
    - Shared button styling through ElevatedButtonThemeData.
    - Shared app bar styling through AppBarTheme.
    - Shared bottom navigation styling through BottomNavigationBarThemeData.

  ## Data Handling and Persistence
  - SharedPreferences is used for lightweight local persistence.
  - The following user-related data is stored locally:
    - Username
    - Email
    - Password
    - Skill level
    - Progress
    - Login state
    - Keep-signed-in preference
  - A dedicated service file is used to isolate local storage logic from UI code.

  ## Program Data Structure
  - Program data is represented using a dedicated Program model.
  - The model supports:
    - Structured object creation
    - JSON serialization
    - JSON deserialization
  - This design makes the application ready for future backend/API integration with minimal structural change.

  ## Important Flutter Widgets and Concepts Used
  - MaterialApp
    - Used as the root application widget.
    - Holds routing, theme configuration, and app-level settings.

  - ThemeData
    - Used to unify colours, typography, input fields, buttons, and navigation styles.

  - Navigator
    - Used for route transitions across the app.
    - Includes push, pushReplacementNamed, and pushNamed patterns.

  - ModalRoute.of(context).settings.arguments
    - Used in Program Details to retrieve the selected Program object.

  - StatefulWidget
    - Used where screen state changes dynamically, such as:
      - Login
      - Sign Up
      - Program Listing
      - Main Layout
      - Home

  - TextEditingController
    - Used to capture, manage, and validate user input.

  - SharedPreferences
    - Used to preserve login and user data between sessions.

  - ListView.builder
    - Used for efficient rendering of the program list.

  - InputFormatters
    - Used to restrict password input in the Sign Up flow.

  ## File Structure
  - lib/main.dart
    - Application entry point, route setup, and global theme setup.

  - lib/models/program.dart
    - Program data model.

  - lib/services/user_prefs.dart
    - SharedPreferences helper and user storage service.

  - lib/screens/login_screen.dart
    - Login UI and login validation logic.

  - lib/screens/signup_screen.dart
    - Sign-up UI, password rules, and user registration storage.

  - lib/screens/home_screen.dart
    - Home dashboard and navigation entry to programs.

  - lib/screens/program_listing_screen.dart
    - Program catalog screen with search and selection.

  - lib/screens/program_details_screen.dart
    - Detailed learner-facing program view.

  - lib/screens/profile_screen.dart
    - User profile display and editing flow.

  - lib/screens/main_layout.dart
    - Bottom navigation wrapper for the core app sections.

  - test/widget_test.dart
    - Basic smoke test for launch verification.

  ## Future Extension Readiness
  - The program listing has been designed in a way that can later accept API or JSON-driven data instead of hardcoded sample data.
  - The Program model already supports JSON mapping.
  - Navigation to Program Details already passes full program objects, which will work well with future backend-fed content.
  - The local storage layer can later be replaced or extended with:
    - REST API integration
    - Firebase Authentication
    - Cloud database storage
    - Secure credential handling



  ## How to Run
  - Ensure Flutter is installed correctly.
  - Run:
    - flutter pub get
    - flutter run

  ## Screenshots
  