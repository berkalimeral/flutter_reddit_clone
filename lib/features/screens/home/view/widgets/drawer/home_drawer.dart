import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/widgets/loader/loader.dart';
import '../../../../community/controller/community_controller.dart';
import 'community_list_drawer.dart';
import 'user_community_list_drawer.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const CommunityListDrawer(),
            ref.watch(userCommunityProvider).when(
                  data: (data) => UserCommunityListDrawer(communities: data),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const Loader(),
                ),
          ],
        ),
      ),
    );
  }
}
