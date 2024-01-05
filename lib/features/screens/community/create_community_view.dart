import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/community_controller.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<CreateCommunityScreen> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void createCommunity(String name) {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(name, context);
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Community'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Community Name'),
            TextField(
              controller: _controller,
              maxLength: 21,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: 'r/Community_name',
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  )),
              onPressed: () => createCommunity(_controller.text),
              child: watch
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Create Community',
                      style: TextStyle(fontSize: 17),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
