import 'package:flutter/material.dart';

import '../apply_now_Screen.dart';

class ApplyNow extends StatelessWidget {
  const ApplyNow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14,
      child: SizedBox(
        height: 90,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => const ApplyNowScreen()),
                ),
              );
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
                  "Apply Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
