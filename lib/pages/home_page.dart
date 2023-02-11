import 'package:belajar_api/model/user_model.dart';
import 'package:belajar_api/services/api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Api'),
      ),
      body: FutureBuilder(
        future: ApiService.fetchUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            UserModel? data = snapshot.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data!.data!.firstName!),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(data.data!.email!),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    data.data!.avatar!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
