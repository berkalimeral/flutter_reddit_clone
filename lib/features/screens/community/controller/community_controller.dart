import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../product/models/community/community_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/community_repository.dart';

final userCommunityProvider = StreamProvider((ref) {
  return ref.watch(communityControllerProvider.notifier).getUsersCommunities();
});

final communityByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
});

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  return CommunityController(
    ref: ref,
    repository: ref.read(communityRepositoryProvider),
  );
});

class CommunityController extends StateNotifier<bool> {
  CommunityController({required repository, required ref})
      : _repository = repository,
        _ref = ref,
        super(false);
  final CommunityRepository _repository;
  final Ref _ref;

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.watch(userProvider)?.uid ?? '';
    CommunityModel community = CommunityModel(
        id: name,
        name: name,
        banner: Constants.bannerDefault,
        avatar: Constants.avatarDefault,
        member: [uid],
        mods: [uid]);

    final response = await _repository.createCommunity(community);
    state = false;
    response.fold((l) => Utilities.showAlert(context, l.message), (r) {
      Utilities.showAlert(context, 'Community created successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<CommunityModel>> getUsersCommunities() {
    final uid = _ref.watch(userProvider)!.uid;
    return _repository.getUsersCommunities(uid);
  }

  Stream<CommunityModel> getCommunityByName(String name) {
    return _repository.getCommunityByName(name);
  }
}
