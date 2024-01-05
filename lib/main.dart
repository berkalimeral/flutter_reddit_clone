import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit_clone/features/screens/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'core/router/router.dart';
import 'core/widgets/loader/loader.dart';
import 'firebase_options.dart';
import 'product/models/user/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getUserData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUser(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.dark(
              useMaterial3: true,
            ),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                getUserData(ref, data);
                if (userModel != null) {
                  return AppRouter.loggedInRoute;
                }
              }
              return AppRouter.loggedOutRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Loader(),
        );
  }
}
