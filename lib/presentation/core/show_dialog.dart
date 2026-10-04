import 'package:flutter/material.dart';

abstract final class ShowDialog {
  static Future<void> showFlitterOptionsDialog({
    required BuildContext buildContext,
    required Widget body,
    double ratio = 0.67,
  }) async {
    await showModalBottomSheet(
      context: buildContext,
      isScrollControlled: true,

      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      barrierColor: Colors.black54,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * ratio,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: body,
            ),
          ),
        );
      },
    );
  }
}
