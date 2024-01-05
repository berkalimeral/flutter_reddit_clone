import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/loader/loader.dart';
import 'controller/community_controller.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectedBannerImage() async {
    final response = await Utilities.pickFile();
    if (response != null) {
      setState(() {
        bannerFile = File(response.files.first.path!);
      });
    }
  }

  void selectedProfileImage() async {
    final response = await Utilities.pickFile();
    if (response != null) {
      setState(() {
        profileFile = File(response.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(communityByNameProvider(widget.name)).when(
          skipLoadingOnReload: true,
          data: (data) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Edit Community'),
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Save'),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: selectedBannerImage,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              color: Colors.white54,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: bannerFile != null
                                    ? Image.file(bannerFile!)
                                    : data.banner.isEmpty ||
                                            data.banner ==
                                                Constants.bannerDefault
                                        ? const Center(
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 35,
                                            ),
                                          )
                                        : Image.network(data.banner),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            bottom: 20,
                            child: GestureDetector(
                              onTap: selectedProfileImage,
                              child: profileFile != null
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage: FileImage(profileFile!),
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(data.avatar),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Loader(),
        );
  }
}
