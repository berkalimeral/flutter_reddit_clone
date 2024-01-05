import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../../../product/models/community/community_model.dart';

class UserCommunityListDrawer extends StatelessWidget {
  const UserCommunityListDrawer({
    super.key,
    required this.communities,
  });

  final List<CommunityModel> communities;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: communities.length,
        itemBuilder: (context, index) {
          final community = communities[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(community.avatar),
            ),
            title: Text('r/${community.name}'),
            onTap: () {
              Routemaster.of(context).push('/r/${community.name}');
            },
          );
        },
      ),
    );
  }
}
