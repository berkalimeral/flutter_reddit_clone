import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controller/auth_controller.dart';
import 'widgets/drawer/home_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(user.profilePic),
            ),
          )
        ],
      ),
      drawer: const HomeDrawer(),
      body: Center(
        child: Text(user.name),
      ),
    );
  }
}
