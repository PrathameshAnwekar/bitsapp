import 'package:bitsapp/models/bits_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../constants/constants.dart';
import 'components/internships_list_view.dart';
import 'components/search_bar.dart';
import 'components/title1.dart';
import 'post_new_internship.dart';
import 'tab_viewer/internship_tabview_screen.dart';

class JobInternhipScreen extends HookConsumerWidget {
  const JobInternhipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    List<String> filteredSkills = [];

    void showMultiSelect(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (ctx) => MultiSelectDialog(
          itemsTextStyle: GoogleFonts.roboto(),
          searchTextStyle: GoogleFonts.roboto(),
          searchHintStyle: GoogleFonts.roboto(),
          selectedItemsTextStyle: GoogleFonts.roboto(),
          separateSelectedItems: true,
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
        toolbarHeight: 85,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 5, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${localUser.name.split(' ')[0]}",
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Let's discover perfect job for you",
                style: GoogleFonts.roboto(
                  color: const Color.fromARGB(255, 123, 123, 123),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 150, 149, 170),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => PostNewInternship()),
                ),
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const InternshipTabView()),
              ),
            ),
            icon: const Icon(
              Icons.assignment_rounded,
              size: 35,
              color: Color.fromARGB(255, 150, 149, 170),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Constants.kSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
              child: Row(
                children: <Widget>[
                  const Flexible(
                    child: SearchBar(),
                  ),
                  GestureDetector(
                    onTap: () => showMultiSelect(context),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          // color: const Color.fromRGBO(255, 118, 84, 1),
                          color: Constants.kPrimaryColor,
                          borderRadius: BorderRadius.circular(15)),
                      height: 55,
                      width: 50,
                      child: SvgPicture.asset(
                        'assets/icons/vertical_filter.svg',
                        color: const Color.fromRGBO(248, 251, 254, 0.95),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: InternshipsListView()),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
