import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageInputField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController textController;
  final bool isReplying;

  const MessageInputField({
    super.key,
    required this.focusNode,
    required this.textController,
    required this.isReplying,
  });

  @override
  Widget build(BuildContext context) {
    const inputBottomRadius = Radius.circular(24);
    return TextField(
      focusNode: focusNode,
      cursorColor: Colors.black,
      controller: textController,
      cursorRadius: const Radius.circular(5),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: true,
      enableSuggestions: true,
      style: GoogleFonts.roboto(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Type a message',
        hintStyle: GoogleFonts.roboto(color: Colors.black54),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: isReplying ? Radius.zero : inputBottomRadius,
            topRight: isReplying ? Radius.zero : inputBottomRadius,
            bottomLeft: inputBottomRadius,
            bottomRight: inputBottomRadius,
          ),
        ),
      ),
    );
  }
}
