import 'package:flutter/material.dart';
import 'package:recap/features/home/repositories/firestore_database_user_repository.dart';
import 'package:recap/features/home/screens/start_screen.dart';

class App extends StatelessWidget {
  final FirestoreDatabaseUserRepository repository;
  const App({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "start",
      onGenerateRoute: (RouteSettings route) {
        switch (route.name) {
          default:
            return MaterialPageRoute(
                builder: (context) => StartScreen(
                      repository: repository,
                    ));
        }
      },
    );
  }
}
