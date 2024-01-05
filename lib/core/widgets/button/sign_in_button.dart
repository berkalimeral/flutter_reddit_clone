import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../assets.dart';
import '../../../features/screens/auth/controller/auth_controller.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  void signInWithGoogle(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var watch = ref.watch(authControllerProvider);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: watch ? null : () => signInWithGoogle(ref, context),
      icon: Image.asset(
        Assets.images.googlePNG,
        height: 30,
      ),
      label: const Text('Continue with Google'),
    );
  }
}
