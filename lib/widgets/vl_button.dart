import 'package:flutter/material.dart';

class VLButton extends StatelessWidget {
  final Text textLabelButton;
  final Color colorTextLabelButton;
  final Icon iconButton;
  final Color colorButton;
  final Color iconColorButton;
  final VoidCallback onPress;
  const VLButton({
    super.key,
    required this.textLabelButton,
    required this.colorTextLabelButton,
    required this.iconButton,
    required this.colorButton,
    required this.iconColorButton,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPress,
        label: textLabelButton,
        icon: iconButton,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorButton),
          iconColor: MaterialStateProperty.all(iconColorButton),
          padding: MaterialStateProperty.all(
            const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: colorTextLabelButton,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          )),
        ),
      ),
    );
  }
}
