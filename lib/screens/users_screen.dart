import 'package:e_commerce_app/models/users_model.dart';
import 'package:e_commerce_app/widgets/users_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_handler.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: APIHandler.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occurred: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const UsersWidget(),
              );
            },
          );
        },
      ),
    );
  }
}

