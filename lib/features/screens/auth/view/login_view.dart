import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../assets.dart';
import '../../../../core/widgets/button/sign_in_button.dart';
import '../../../../core/widgets/loader/loader.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          Assets.images.logoPNG,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Skip'),
          )
        ],
      ),
      body: watch
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Dive into anything',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Image.asset(
                    Assets.images.loginEmotePNG,
                    height: 500,
                  ),
                  const SignInButton(),
                ],
              ),
            ),
    );
  }
}
