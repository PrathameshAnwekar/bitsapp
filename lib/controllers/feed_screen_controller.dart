import 'package:bitsapp/views/search/profile_search_delegate.dart';
import 'package:flutter/material.dart';

class FeedScreenController {
  static Future goToSearch(context, ref) async{
    return showSearch(context: context, delegate: ProfileSearchDelegate(ref: ref));
  }
}
