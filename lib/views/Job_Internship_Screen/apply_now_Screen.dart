import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsapp/views/Job%20Internship%20Screen%20/components/back_submit_button.dart';
import 'package:bitsapp/views/Job%20Internship%20Screen%20/components/heading1.dart';
import 'package:bitsapp/views/Job%20Internship%20Screen%20/components/heading2.dart';
import 'package:flutter/material.dart';

class ApplyNowScreen extends StatelessWidget {
  const ApplyNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      bottomNavigationBar: const BackSubmitButton(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Heading1(txt: "Your resume", top: 20, bottom: 10),
              Container(
                height: 250,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFdfdee8).withOpacity(0.8),
                ),
              ),
              const Heading1(txt: "Contact details", top: 25, bottom: 5),
              const Heading2(txt1: "Phone Number: ", txt2: "8220585181"),
              const Heading2(
                  txt1: "Email Id: ", txt2: "aryabamboli2002@gmail.com"),
              const Heading1(txt: "Cover letter", top: 25, bottom: 5),
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
