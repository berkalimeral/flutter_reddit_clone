import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/widgets/loader/loader.dart';
import '../auth/controller/auth_controller.dart';
import 'controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: ref.watch(communityByNameProvider(name)).when(
            data: (community) {
              return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 200,
                        floating: true,
                        snap: true,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                community.banner,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Align(
                                alignment: Alignment.topLeft,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(community.avatar),
                                  radius: 35,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('r/$name'),
                                  community.mods.contains(user?.uid)
                                      ? OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20)),
                                          onPressed: () {
                                            Routemaster.of(context)
                                                .push('/mod-tools/$name');
                                          },
                                          child: const Text('Mod Tools'),
                                        )
                                      : OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20)),
                                          onPressed: () {},
                                          child: const Text('Join'),
                                        ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child:
                                    Text('${community.member.length} members'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Container());
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Loader(),
          ),
    );
  }
}
