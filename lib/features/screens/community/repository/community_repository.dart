import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/failure.dart';
import '../../../../core/type_defs.dart';
import '../../../../product/models/community/community_model.dart';
import '../../../../product/provider/firebase_provider.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return CommunityRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
  );
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository({required firestore}) : _firestore = firestore;

  CollectionReference get _communityCollection =>
      _firestore.collection(FirebaseConstants.communitiesCollection);

  FutureVoid createCommunity(CommunityModel community) async {
    try {
      var communityDoc = await _communityCollection.doc(community.name).get();
      if (communityDoc.exists) {
        throw 'Community with the same name already exists!';
      }
      return right(
          _communityCollection.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<CommunityModel>> getUsersCommunities(String uid) {
    return _communityCollection
        .where('member', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<CommunityModel> communities = [];
      for (var doc in event.docs) {
        communities
            .add(CommunityModel.fromMap(doc.data() as Map<String, dynamic>));
      }
      return communities;
    });
  }

  Stream<CommunityModel> getCommunityByName(String name) {
    return _communityCollection.doc(name).snapshots().map((event) {
      return CommunityModel.fromMap(event.data() as Map<String, dynamic>);
    });
  }
}
