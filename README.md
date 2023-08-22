# To Do 
---
"To Do" App using Flutter with advanced features. 🌟
Built using BloC architecture and SQLite to store data.:

#### Functionality:

Basic
 ☑ Add, Edit and Delete Task\
 ☑ Add, Edit and Delete Category\
 ☑ Mark as Done, Later and Important\
 ☑ Add due date\
 ☑ Light/Dark mode\
 
## How to start 
---
```dart
git clone https://github.com/weluid/Todo-App.git
cd Todo-App
flutter packages get
flutter run
```
Does not work without connection to the Firebase api*

## Tech
---
Libraries used in the project:

- [Bloc] - makes it easy to separate UI from business logic, making code fast and reusable
- [Sqflite] - allows Flutter apps to discover network connectivity
- [Flutter Localization] - provides localization facilities, including message translation
- [Animated theme switcher] - animation to change the theme 
- [Flutter slidable] -  implementation of slidable list item with directional slide actions that can be dismissed
- [Firebase Core] - connecting app to Firebase
- [Firebase Crashlytics] - realtime crash reporter that helps you track, prioritize, and fix errors

## Database manager
---
##### The app has 2 managers: SQLite and cache

Navigate to lib/main.dart if you want to switch between them and change this line by `Manager` values
For example, you can switch to cache using the `CacheManager()` value instead of `SqlDatabase()`
```dart
 ToDoRepository.getInstance(SqlDatabase())
```




   [OpenWeatherMap]: <https://openweathermap.org/>
   [Bloc]: <https://pub.dev/packages/flutter_bloc>
   [Animated theme switcher]: <https://pub.dev/packages/animated_theme_switcher>
   [Http]: <https://pub.dev/packages/http>
   [Dio]: <https://pub.dev/packages/dio>
   [Flutter slidable]: <https://pub.dev/packages/flutter_slidable>
   [Sqflite]: <https://pub.dev/packages/sqflite>
   [Flutter Localization]: <https://pub.dev/packages/flutter_localization>
   [Firebase Core]: <https://pub.dev/packages/firebase_core>
   [Firebase Crashlytics]: <https://pub.dev/packages/firebase_crashlytics>
