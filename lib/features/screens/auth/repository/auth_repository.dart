import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/failure.dart';
import '../../../../core/type_defs.dart';
import '../../../../product/models/user/user_model.dart';
import '../../../../product/provider/firebase_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
      firebaseAuth: ref.read(firebaseAuthProvider),
      firestore: ref.read(firebaseFirestoreProvider),
      googleSignIn: ref.read(googleSignInProvider));
});

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  CollectionReference get _userCollection =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  AuthRepository(
      {required firebaseAuth, required firestore, required googleSignIn})
      : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await account!.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      UserModel user;

      if (userCredential.additionalUserInfo!.isNewUser) {
        user = UserModel(
          name: userCredential.user!.displayName!,
          uid: userCredential.user!.uid,
          profilePic: userCredential.user?.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          karma: 0,
          isAuthenticated: true,
          award: const [],
        );
        var userJson = user.toMap();
        await _userCollection.doc(user.uid).set(userJson);
      } else {
        user = await getUser(userCredential.user!.uid).first;
      }
      return right(user);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUser(String uid) {
    return _userCollection.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
