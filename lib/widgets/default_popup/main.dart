import 'package:flutter/material.dart';

class PopupModal extends StatelessWidget {
  final void Function() process;
  final String title;
  final String description;
  final String buttonText;
  final BuildContext parentContext;
  const PopupModal({
    super.key,
    required this.process,
    required this.buttonText,
    required this.description,
    required this.title,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 19),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const SizedBox(
              height: 50,
              width: 50,
              child: Icon(Icons.close, color: Colors.black, size: 27),
            ),
          )
        ],
      ),
      content: Text(
        description,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        InkWell(
          onTap: () {
            process();
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
