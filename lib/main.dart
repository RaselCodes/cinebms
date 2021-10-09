import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'screens/login_screen.dart';
import 'screens/loading.dart';
import 'screens/something_went_wrong.dart';
import 'screens/a_movie_details_screen.dart';
import 'screens/feed_screen.dart';
import 'screens/movie.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'CineBMS',
      home: const App(),
      onGenerateRoute: (settings){
        if(settings.name == 'FeedScreen'){
          return MaterialPageRoute(
              builder: (context) {
                return const FeedScreen();
              }
          );
        }
        if(settings.name == 'AMovieDetailsScreen'){
          Movie? movie = settings.arguments as Movie;
          return MaterialPageRoute(
              builder: (context) {
                return AMovieDetailsScreen(movie: movie);
              }
          );
        }
      },
    )
  );

}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          if(FirebaseAuth.instance.currentUser != null){
            return const FeedScreen();
          }
          return const LoginScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}