# Flutter Quiz App with Cubit State Management

A mobile quiz application with timer functionality built using Flutter and Cubit for state management.

## App Features

### Timed Quiz Questions
Each question has a countdown timer that automatically advances to the next question when time expires.

### Cubit State Management
Uses the BLoC pattern with Cubit for efficient, testable state management with clear separation of concerns.

### Detailed Results
After completing the quiz, users can view their score, time spent, and review all questions with correct answers.

### Responsive UI
Clean, modern interface that works across multiple screen sizes with animated transitions between states.

### Quiz Repository
Modular design with a repository pattern that could easily connect to a backend API for dynamic questions.

## Architecture Overview

The app follows a clean architecture with Cubit state management:

### Data Layer
- `Question` and `Option` models
- `QuizResult` and `UserAnswer` models
- `QuizRepository` for data fetching

### State Management
- `QuizCubit` for managing quiz flow and user answers
- `TimerCubit` for managing countdown timer
- Separate state classes for maintaining immutability

### Presentation Layer
- Welcome Screen with app introduction
- Quiz Screen with questions and timer
- Result Screen with detailed performance analysis

### UI Components
- Question Card for displaying questions
- Option Button for multiple choice answers
- Timer Display with progress visualization
- Navigation controls for moving between questions

## State Management with Cubit

The app uses two main Cubits to manage state:

### Quiz Cubit
Manages the overall quiz flow including:
- Loading questions from repository
- Tracking user answers
- Calculating scores
- Moving between questions
- Completing the quiz and generating results

### Timer Cubit
Manages the countdown timer for each question:
- Starting and resetting the timer
- Updating time remaining
- Pausing and resuming (for future enhancement)
- Notifying when time expires
- Tracking elapsed time for statistics

## User Flow

1. User starts on the **Welcome Screen** with app introduction
2. Tapping "Start Quiz" loads questions and navigates to the **Quiz Screen**
3. Timer starts automatically for each question
4. User selects an answer or timer expires
5. App advances to next question or completes quiz
6. User views detailed performance on the **Result Screen**
7. Options to retry quiz or return to welcome screen

## Technical Implementation

The app is built with:
- **Flutter:** UI framework for cross-platform development
- **flutter_bloc:** For implementing the Cubit pattern
- **equatable:** For efficient state comparison
- **shared_preferences:** For storing quiz history (future enhancement)

All state changes follow a unidirectional data flow, making the app predictable and testable.


## Project Structure

```
lib/
├── cubit/             # State management
│   ├── quiz/          # Quiz state and cubit
│   └── timer/         # Timer state and cubit
├── models/            # Data models
├── repositories/      # Data access
├── screens/           # UI screens
├── utils/             # Utilities
├── widgets/           # Reusable UI components
├── app.dart           # App configuration
└── main.dart          # Entry point
```