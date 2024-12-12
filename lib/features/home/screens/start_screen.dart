import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recap/features/home/repositories/firestore_database_user_repository.dart';

class StartScreen extends StatelessWidget {
  final FirestoreDatabaseUserRepository repository;
  const StartScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: repository.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  );
                } else if (snapshot.connectionState != ConnectionState.done) {
                  return const CupertinoActivityIndicator();
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final bool hasAbgaben = user.abgaben.isNotEmpty;
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.role),
                          trailing: Text(hasAbgaben
                              ? "${user.abgaben.length} Abgaben"
                              : "Keine Abgaben"),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: users.length);
                }
                return Container();
              })),
    );
  }
}
