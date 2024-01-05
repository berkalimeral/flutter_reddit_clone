import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/controller/auth_controller.dart';

class SignOutDrawer extends ConsumerWidget {
  const SignOutDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Sign Out'),
      leading: const Icon(Icons.logout),
      onTap: () => ref.read(authControllerProvider.notifier).signOut(),
    );
  }
}
