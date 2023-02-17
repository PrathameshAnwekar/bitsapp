import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ApplyNowScreen extends StatelessWidget {
  const ApplyNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        backgroundColor: const Color(0xFFF7F6F8),
        title: AutoSizeText(
          "Apply for Social Media Manager",
          style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 20),
          maxLines: 2,
        ),
        elevation: 0,
      ),
      bottomNavigationBar: _bottomWidget(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _heading1("Your resume", 20, 10),
              Container(
                height: 250,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFdfdee8).withOpacity(0.8),
                ),
              ),
              _heading1("Contact details", 25, 5),
              _heading2("Phone Number: ", "8220585181"),
              _heading2("Email Id: ", "aryabamboli2002@gmail.com"),
              _heading1("Cover letter", 25, 5),
              TextFormField(
                // focusNode: _descFocus,
                cursorColor: const Color(0xFF383D51).withOpacity(0.8),
                // controller: desccontroller,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 6,
                maxLines: 7,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(27, 27, 27, 1),
                ),
                maxLength: 400,
                // onFieldSubmitted: (_) {
                //   _fieldFocusChange(
                //       context, _descFocus, _priceFocus);
                // },
                // onSaved: (value) {
                //   _editeditem = Item(
                //     title: _editeditem.title,
                //     description: value!,
                //     price: _editeditem.price,
                //     category: _editeditem.category,
                //     profileId: _editeditem.profileId,
                //     imageList: _editeditem.imageList,
                //     id: _editeditem.id,
                //   );
                // },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Field cannot be empty";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
                  hintText:
                      'Mention what relevant skill or past experience you have for this internship',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _heading1(String txt, double top, double bottom) {
  return Padding(
    padding: EdgeInsets.only(
      top: top,
      bottom: bottom,
    ),
    child: Text(
      txt,
      style: const TextStyle(
        color: Color(0xFF4D5470),
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
  );
}

Widget _heading2(String txt, String txt2) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          txt,
          style: const TextStyle(
            color: Color(0xFF4D5470),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Text(
          txt2,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

Widget _bottomWidget(BuildContext context) {
  return Material(
    elevation: 14,
    child: SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF149fda),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              child: const Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFF149fda),
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                    const SnackBar(
                      content: Text("Succesfuly Applied"),
                      backgroundColor: Color.fromRGBO(237, 92, 90, 1),
                    ),
                  )
                  .closed
                  .then((value) => Navigator.pop(context));
            },
            child: Card(
              color: const Color(0xFF149fda),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shadowColor: const Color(0xFF149fda).withOpacity(0.6),
              elevation: 6,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
