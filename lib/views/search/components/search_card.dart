import 'package:bitsapp/controllers/search_controller.dart' as sc;
import 'package:bitsapp/models/bits_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchCard extends HookConsumerWidget {
  const SearchCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final BitsUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return InkWell(
      onTap: () {
        sc.SearchController.goToUserProfile(context, user);
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10 * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                 CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(user.profilePicUrl ?? 'https://picsum.photos/50/50?'),
                ),
                if (true)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
