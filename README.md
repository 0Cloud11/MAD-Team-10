# Project Overview
Excelerate is a Flutter-based learner support app designed to help students explore AI-related programs, discover essential skill-building opportunities, and interact with structured learning content in a clean and accessible way.

# Project Objective
This project aims to deliver a complete Excelerate App with key learner-facing screens, smooth navigation, consistent branding, integrated mock data, and working forms for user interaction and feedback.

# Project Vision
A clean, polished, and intuitive app experience that remains easy to navigate while presenting a professional and consistent brand identity.

# Core Features
- Login and Sign Up flow
- Home dashboard
- Program Listing
- Program Details
- Feedback / Form interaction
- Profile and session management
- Splash screen and branded UI
- Mock API / JSON-style data integration
- Loading, validation, and error handling

# Navigation Flow
Splash Screen -> Login page <-> Sign up page <-> Home Screen <-> Program Listing <-> Program Details <-> Feedback Form <-> Profile/Settings

# Links
Here are the links to Documents (Google Docs), Wireframes (Figma), and our Repository (GitHub):

**Documents (Google Docs):**
- Team Charter: [Link](https://docs.google.com/document/d/1lLF50O7wYWmP6jm1J4IVdEzwUwkKl7glbSfSo-8WfNg/edit?usp=sharing)
- App Proposal: [Link](https://docs.google.com/document/d/1GflEMeTm0yuZW-8igsAJZOc7CTsPdgmG88C7VsFxF2I/edit?usp=sharing)

**Wireframes (Figma):**
- [Link](https://www.figma.com/design/HYcJIbpcJ9kRh3RT8ktdcw/MAD_Team10_Wireframs?node-id=2-3&t=zQYRFB0t0V9swEaL-1)

**Repository (GitHub):**
- [Link](https://github.com/0Cloud11/MAD-Team-10)

# Setup Instructions
- Clone the repository from GitHub.
- Open the project in VS Code or Android Studio.
- Ensure Flutter SDK is installed correctly.
- Run the following commands:

```bash
flutter pub get
flutter run
```

# Week 1 Update
Initial project setup completed.
Wireframing and Figma Mock-up created.

## Screenshots
<img width="501" height="792" alt="image" src="https://github.com/user-attachments/assets/322b20f9-7fa7-4928-ad57-2f0d2cf5ad48" />
<img width="433" height="762" alt="image" src="https://github.com/user-attachments/assets/bf28d065-35db-44dd-9a1e-aff72fba060b" />
<img width="400" height="789" alt="image" src="https://github.com/user-attachments/assets/6fc6db3e-1093-4824-8422-65ff4267c973" />
<img width="410" height="782" alt="image" src="https://github.com/user-attachments/assets/da57ffa8-35a9-4b8d-8003-a626365ca655" />
<img width="419" height="773" alt="image" src="https://github.com/user-attachments/assets/6807a543-116a-43b9-9f17-661aa39a7e7c" />

# Week 2 Update
## AI Course App Prototype
A functional Flutter UI prototype was developed to establish the foundation of the Excelerate learner experience.

## Implemented Screens

### Login Screen
- Authenticates users by matching entered username or email and password against locally stored user data.
- Includes a show/hide password toggle for improved usability.
- Supports persistent sessions through a “Keep me signed in” option using local storage.

### Sign Up Screen
- Captures username, email, and password for new users.
- Enforces password rules such as minimum and maximum length, uppercase and lowercase letters, numeric values, special characters, and no spaces.
- Displays a live password strength indicator and helpful improvement suggestions.
- Saves the user record locally and redirects the learner back to the Login screen after successful registration.

### Home Screen
- Serves as the main learner dashboard after login.
- Displays a branded welcome section.
- Provides direct navigation to the Program Listing screen.
- Supports a simple, clear learner journey through the app.

### Program Listing Screen
- Displays available programs in a clean card-based layout.
- Includes search functionality to help users find relevant programs quickly.
- Uses rendering logic that is adaptable for future API-fetched program collections.
- Opens the Program Details screen when a program is selected.

### Program Details Screen
- Displays detailed information for the selected program, including title, description, date, schedule, eligibility, instructor, and rating.
- Dynamically receives program data through route arguments.
- Includes a registration action flow for future expansion.

### Profile Screen
- Displays locally stored learner profile information.
- Supports profile editing functionality.
- Supports logout and clears the current login session state.

## Navigation Logic
- Flutter navigation was implemented to handle movement across screens.
- Named routes were configured in `MaterialApp` for scalability and maintainability.
- Program data is passed dynamically between listing and detail views using route arguments.
- Core learner flow:
  - Login -> Home
  - Home -> Program Listing
  - Program Listing -> Program Details
  - Program Details -> Back to Program Listing
- A bottom navigation bar was added for quick access to Home, Programs, and Profile sections.

## Theming and Branding
- A global `ThemeData` configuration was applied in `main.dart`.
- Shared visual styles were defined for text fields, buttons, app bars, and bottom navigation.
- Primary and secondary colors were used consistently across major screens.

## Data Handling and Persistence
- `SharedPreferences` was used for lightweight local persistence.
- User-related data stored locally includes:
  - Username
  - Email
  - Password
  - Skill level
  - Progress
  - Login state
  - Keep-signed-in preference
- A dedicated service file was used to separate persistence logic from UI code.

## Program Data Structure
- Program data was represented using a dedicated `Program` model.
- The model supports:
  - Structured object creation
  - JSON serialization
  - JSON deserialization
- This structure prepared the application for later backend or API integration.

## Important Flutter Concepts Used
- **MaterialApp & ThemeData** for root-level app setup and global styling.
- **Navigator & Routes** for screen-to-screen transitions.
- **StatefulWidget** for screens with dynamic state changes.
- **TextEditingController** for input handling.
- **SharedPreferences** for persistent local storage.
- **ListView.builder** for efficient list rendering.
- **InputFormatters** for restricting password inputs.

## Future Extension Readiness
- Program screens were designed so hardcoded UI content could later be replaced by API or JSON data.
- The `Program` model already supports JSON mapping.
- The storage layer can later be extended with REST APIs, Firebase Authentication, or cloud-based databases.

## How to Run
- Ensure Flutter is installed correctly on your machine.
- Run:
  ```bash
  flutter pub get
  flutter run
  ```

## Screenshots
<img width="367" height="491" alt="image" src="https://github.com/user-attachments/assets/749f9353-3cac-4bbc-87f5-2d81495eb9df" />
<img width="367" height="472" alt="image" src="https://github.com/user-attachments/assets/953e6077-0cf4-4217-9bec-60c41cf91224" />
<img width="359" height="500" alt="image" src="https://github.com/user-attachments/assets/88cdd560-b25a-4d29-a5a9-2bb46fb5b178" />
<img width="355" height="495" alt="image" src="https://github.com/user-attachments/assets/48946ea3-cb20-49af-a757-2cfc3d4b552d" />
<img width="356" height="491" alt="image" src="https://github.com/user-attachments/assets/e7ce4a09-6d9c-45cf-84f1-79c14277b777" />
<img width="352" height="489" alt="image" src="https://github.com/user-attachments/assets/d19265ee-0f02-4aed-993e-55526a3a00ba" />
<img width="349" height="494" alt="image" src="https://github.com/user-attachments/assets/20ed3798-fe3f-4a2a-b6ea-a558f9aff8bc" />
<img width="347" height="493" alt="image" src="https://github.com/user-attachments/assets/2547d884-1149-423b-9ee8-4281327fae32" />

# Week 3 Update
## Dynamic State, Mock APIs, and Interactive Forms
Week 3 focused on transforming the app from a mostly visual prototype into a more functional and interactive product by integrating mock data, asynchronous loading, validation, and feedback mechanisms.

## Key Features Implemented

### 1. Mock API Integration & Asynchronous Data Fetching
- A simulated asynchronous API call, `Program.fetchPrograms()`, was implemented inside the `Program` model.
- Artificial delay using `Future.delayed` was introduced to simulate network loading and allow proper testing of loading states.
- The **Home Screen** and **Program Listing Screen** were updated to fetch program data dynamically instead of relying purely on static display content.

### 2. State Management & Loading Indicators
- Screens were updated to support `Loading`, `Success`, and `Error` states.
- `FutureBuilder` was used on the Home screen to rebuild the UI according to asynchronous data states.
- `setState` and boolean flags such as `_isLoading` were used on the Program Listing screen to control fetch and display states.
- `CircularProgressIndicator` was added to improve user feedback during loading.

### 3. Error Handling and Defensive UI
- `try-catch` handling was added around asynchronous program fetch operations.
- If mock data loading fails, the UI displays an error message and a retry action instead of failing silently.

### 4. Interactive Feedback Form
- A new **Feedback Screen** was introduced.
- A `Form` with `GlobalKey<FormState>` was used for structured validation.
- `TextFormField` and `DropdownButtonFormField` were added for name, email, feedback category, and comments.
- Required field validation and email validation were implemented.
- Submission shows a loading state and success feedback through a `SnackBar`.

### 5. Program Registration Flow
- The Program Details experience was improved by replacing a static action with an interactive registration flow.
- A dialog-based registration form was introduced.
- Validation and submission feedback were added to create a more realistic user interaction flow.

### 6. Dark Theme Refinement
- The global theme was extended to support a more polished dark mode.
- Dark surfaces, input fields, navigation elements, and accent styling were refined to better match the app’s brand identity.

## Important Flutter Widgets and Concepts Used
- **FutureBuilder**
- **CircularProgressIndicator**
- **RefreshIndicator**
- **Form & GlobalKey<FormState>**
- **DropdownButtonFormField**
- **showDialog & StatefulBuilder**

## Screenshots
<img width="364" height="495" alt="image" src="https://github.com/user-attachments/assets/4cf5acd9-dab8-41fe-8ef6-43df24dc092d" />
<img width="357" height="485" alt="image" src="https://github.com/user-attachments/assets/6c94f19d-83e6-484b-b81b-792cc89323a6" />

# Week 4 Update
## Final UI Refinement, Branding, and Presentation Readiness
Week 4 focused on polishing the final app for submission and presentation by refining the overall UI/UX, improving branding consistency, and preparing the codebase and documentation as a stronger portfolio-ready project.

## Key Improvements Completed

### 1. Consistent Excelerate Branding
- Applied a more unified Excelerate visual identity across the app.
- Standardized the use of branded colors across buttons, app sections, cards, highlights, and navigation elements.
- Improved text hierarchy and screen headers so the UI feels more polished and consistent.

### 2. Splash Screen Added
- Added a dedicated **Splash Screen** for the Excelerate app.
- The splash screen improves first impression and strengthens branding before the user enters the authentication or main app flow.
- The splash flow routes users appropriately into login or the main experience.

### 3. UI/UX Refinement
- Refined layout spacing, card styling, and section presentation across major screens.
- Improved consistency between Login, Sign Up, Home, Program Listing, Program Details, Feedback, and Profile screens.
- Preserved all previously working features while improving clarity and visual quality.

### 4. Validation and Navigation Review
- Rechecked form validation flows to ensure they remain functional and understandable.
- Preserved smooth navigation between major learner journeys:
  - Splash -> Login / Main
  - Login -> Home
  - Home -> Program Listing
  - Program Listing -> Program Details
  - Program Details -> Registration
  - Main navigation -> Feedback / Profile
- Ensured the app structure remains intuitive and presentation-ready.

### 5. Documentation and Submission Readiness
- README content was polished and expanded for final GitHub submission.
- Setup instructions, project overview, weekly progress, screenshots, and changelog-style updates were organized more clearly.
- The repository is now better structured as both an internship deliverable and a portfolio piece.

# Final App Summary
The final Excelerate App includes:
- Login Screen
- Sign Up Screen
- Splash Screen
- Home Screen
- Program Listing Screen
- Program Details Screen
- Feedback Form
- Profile Screen
- Mock API / JSON-style dynamic program data
- Validation, loading indicators, and error handling
- Consistent branding and dark theme support

# Contribution / Changelog Summary

## Week 1
- Project setup completed
- Wireframes and initial app planning completed

## Week 2
- Core learner screens built
- Navigation flow implemented
- Local persistence added
- Program model and reusable structure introduced

## Week 3
- Mock API / JSON-style program data integrated
- Loading states and error handling implemented
- Feedback and registration forms added
- Dark theme refined

## Week 4
- Excelerate branding unified across the app
- Splash screen added
- UI/UX polished for final submission
- README refined for GitHub presentation

# Reflection Note
This project provided a complete learning journey through Flutter app development, beginning with planning and wireframing, then progressing into navigation, persistence, mock data integration, forms, loading states, and UI refinement.

Through this process, important skills were strengthened in screen design, state management, debugging, user input validation, and structuring an app for future scalability. One of the most valuable lessons was understanding how to move from a static prototype toward a more realistic, interactive product by introducing dynamic data handling and user feedback systems.

The internship experience also highlighted the importance of polishing presentation quality, documentation, and project structure, not only building functionality. This helped develop a more professional mindset toward app development and portfolio preparation.

# Future Recommendations
- Integrate a real backend API for live program and announcement data.
- Add secure authentication for production use.
- Introduce admin-facing controls for program and announcement management.
- Add push notifications and richer learner progress tracking.
- Expand accessibility and device responsiveness testing.

# Repository Notes
Before pushing the final version:
- Verify screenshots are up to date.
- Use meaningful commit messages.
- Confirm that all Week 4 UI refinements are saved in the final codebase.

# Contributors
- Renit
