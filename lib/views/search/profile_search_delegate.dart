import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/views/search/components/search_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  ProfileSearchDelegate({required this.ref}) {
    searchTerms = ref.watch(contactsListProvider);
  }

  late List<BitsUser> searchTerms;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    query = query.toLowerCase();
    for (var user in searchTerms) {
      final emailBool = user.email.contains(query);
      if (emailBool) {
        matchQuery.add(user);
        continue;
      }
      final nameBool = user.name.toLowerCase().contains(query);
      if (nameBool) {
        matchQuery.add(user);
        continue;
      }
      final expOrgBool = user.userExperience != null
          ? user.userExperience!
              .map((e) => e.description)
              .toList()
              .contains(query)
          : false;
      if (expOrgBool) {
        matchQuery.add(user);
        continue;
      }
      final expTitleBool = user.userExperience != null
          ? user.userExperience!.map((e) => e.title).toList().contains(query)
          : false;
      if (expTitleBool) {
        matchQuery.add(user);
        continue;
      }
      final descBool = user.profileDescription != null
          ? user.profileDescription!.toLowerCase().contains(query)
          : false;
      if (descBool) {
        matchQuery.add(user);
        continue;
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return SearchCard(user: result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    query = query.toLowerCase();
    for (var user in searchTerms) {
      if (user.name.toLowerCase().contains(query)) {
        matchQuery.add(user);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return SearchCard(user: result);
      },
    );
  }
}
