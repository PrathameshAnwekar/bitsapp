import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import 'components/internships_list_view.dart';
import 'components/search_bar.dart';
import 'components/title1.dart';
import 'post_new_internship.dart';
import 'tab_viewer/internship_tabview_screen.dart';

class JobInternhipScreen extends HookConsumerWidget {
   JobInternhipScreen({super.key});

   final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh(WidgetRef ref) async {
    // monitor network fetch
    await FirestoreService.initInternshipData(ref);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    List<String> filteredSkills = [];

    void showMultiSelect(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (ctx) => MultiSelectDialog(
          initialValue: filteredSkills,
          backgroundColor: Colors.white,
          height: 400,
          searchable: true,
          title: const Title1(txt: "Filter by skills"),
          items: Constants.skills.map((e) => MultiSelectItem(e, e)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            filteredSkills = values;
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "Hello ${localUser.name}",
            style: GoogleFonts.dmSans(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: 23,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.all(1),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(49, 50, 54, 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => PostNewInternship()),
                ),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 28,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const InternshipTabView()),
              ),
            ),
            icon: Icon(
              Icons.format_align_left_rounded,
              size: 28,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 15),
              child: Row(
                children: <Widget>[
                  const Flexible(
                    child: SearchBar(),
                  ),
                  GestureDetector(
                    onTap: () => showMultiSelect(context),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 118, 84, 1),
                          borderRadius: BorderRadius.circular(15)),
                      height: 65,
                      width: 60,
                      child: SvgPicture.asset(
                        'assets/icons/vertical_filter.svg',
                        color: const Color.fromRGBO(248, 251, 254, 0.95),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    controller: _refreshController,
                    header:  BezierCircleHeader(),
                    onLoading: () => _onLoading(),
                    onRefresh: () => _onRefresh(ref),
                    child: InternshipsListView())),
          ],
        ),
      ),
    );
  }
}
