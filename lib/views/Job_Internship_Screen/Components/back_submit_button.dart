import 'package:flutter/material.dart';

class BackSubmitButton extends StatelessWidget {
  const BackSubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                child: const Text(
                  "Back",
                  style: TextStyle(
                    color: Color(0xFF149fda),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
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
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
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
}
