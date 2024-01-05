import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/utils.dart';
import '../../../../product/models/user/user_model.dart';
import '../repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        repository: ref.watch(authRepositoryProvider), ref: ref));

final authStateChangeProvider = StreamProvider(
    (ref) => ref.watch(authControllerProvider.notifier).authStateChanges);

final getUserProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(authControllerProvider.notifier).getUser(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repository;
  final Ref _ref;

  AuthController({required repository, required ref})
      : _repository = repository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChanges => _repository.authStateChanges;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _repository.signInWithGoogle();
    state = false;
    user.fold(
        (l) => Utilities.showAlert(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }

  Stream<UserModel> getUser(String uid) {
    return _repository.getUser(uid);
  }

  Future<void> signOut() async {
    await _repository.signOut();
  }
}
