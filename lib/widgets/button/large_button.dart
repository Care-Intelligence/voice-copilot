import 'package:flutter/material.dart';
import 'package:voice_copilot/widgets/default_popup/main.dart';

class Button extends StatelessWidget {
  final BuildContext speechContext;
  final String text;
  final void Function() confirmProcess;
  const Button(
      {super.key,
      required this.confirmProcess,
      required this.speechContext,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Chama a função _showDialog passando o contexto do widget pai
        _showDialog(speechContext);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrangeAccent),
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepOrangeAccent,
        ),
        margin: const EdgeInsets.only(
          left: 45,
          right: 15,
          top: 10,
          bottom: 10,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopupModal(
        parentContext: speechContext,
        process: confirmProcess,
        buttonText: "Confirmar",
        description: "Deseja confirmar a ação.",
        title: "Confirmar",
      ),
    );
  }
}
