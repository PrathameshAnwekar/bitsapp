import 'package:bitsapp/models/bits_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendMessageCard extends HookConsumerWidget {
  const SendMessageCard({
    Key? key,
    required this.user,
    required this.shareList,
  }) : super(key: key);

  final BitsUser user;
  final ValueNotifier<List<String>> shareList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectStatus = useState(false);
    return InkWell(
      onTap: () {
        selectStatus.value = !selectStatus.value;
        if (selectStatus.value) {
          shareList.value.add(user.uid);
        } else {
          shareList.value.remove(user.uid);
        }
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10 * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 24,
                  // backgroundImage: AssetImage(chat.image),
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
            Icon(
              Icons.circle,
              color: selectStatus.value ? Colors.green : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
