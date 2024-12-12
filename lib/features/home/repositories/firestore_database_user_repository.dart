import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recap/features/home/repositories/database_user_repository.dart';
import 'package:recap/features/home/schema/user/abgabe.dart';
import 'package:recap/features/home/schema/user/user.dart';

class FirestoreDatabaseUserRepository implements DatabaseUserRepository {
  final FirebaseFirestore instance;
  FirestoreDatabaseUserRepository(this.instance);

  @override
  Future<List<Abgabe>> getAbgaben(String userId) async {
    final abgabenDocuments = await instance
        .collection("users")
        .doc(userId)
        .collection("abgaben")
        .get();

    List<Abgabe> abgaben = [];

    if (abgabenDocuments.docs.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in abgabenDocuments.docs) {
        final data = document.data();
        abgaben.add(Abgabe.fromMap(data));
      }
    }

    return abgaben;
  }

  @override
  Future<List<User>> getUsers() async {
    /// Abrufen aller User-Dokumente
    final userDocuments = await instance.collection("users").get();
    // userDocuments -> List<Map<String,dynamic>> - Mehrere Dokumente

    // final userDocument = await instance.collection("users").doc("hallo123").get() -> Map<String,dynamic> - Ein Dokument

    // instance.collection("users").doc("hallo123").set({}) <- überschreiben
    // instance.collection("users").add();  <- neu hinzufügen

    /// Erstellen einer leeren Liste
    List<User> users = [];

    /// Überprüfen, gibt es überhaupt Dokumente?
    if (userDocuments.docs.isNotEmpty) {
      /// Jedes Dokument durch
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in userDocuments.docs) {
        /// Ziehen uns die JSON Daten
        final data = document.data();

        /// Erstellen wir eine leere Abgabe-Liste
        List<Abgabe> abgaben = [];

        // Ist es ein Teilnehmer? - Wenn Ja, dann rufen wir die Abgaben ab
        if (data["role"] == "Teilnehmer") {
          /// Hier setzen wir die Abgaben in die Liste
          abgaben = await getAbgaben(document.id);
        }

        /// Fügen den Nutzer in unsere Liste hinzu
        users.add(User.fromMap(data, abgaben));
      }
    }

    return users;
  }
}
