import 'package:bitsapp/models/bits_user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/contact_card.dart';

class ContactsScreen extends HookConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsList = ref.watch(contactsListProvider).toList();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: contactsList.length,
                  itemBuilder: (context, index) {
                    return ContactCard(user: contactsList[index]);
                  })),
        ],
      ),
    );
  }
}