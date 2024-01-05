import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends StatelessWidget {
  const CommunityListDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Creat a Community'),
      leading: const Icon(Icons.add),
      onTap: () {
        Routemaster.of(context).push('/create-community');
      },
    );
  }
}
