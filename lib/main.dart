import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recap/app.dart';
import 'package:recap/features/home/repositories/firestore_database_user_repository.dart';
import 'package:recap/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final instance = FirebaseFirestore.instance;

  final repository = FirestoreDatabaseUserRepository(instance);

  runApp(App(repository: repository));
}
