import 'package:e_commerce_app/screens/app_screen.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/material.dart';

class CheckoutCompletePage extends StatefulWidget {
  const CheckoutCompletePage({super.key});

  @override
  State<CheckoutCompletePage> createState() => _CheckoutCompletePageState();
}

class _CheckoutCompletePageState extends State<CheckoutCompletePage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = Colors.black;
  Color themeColor = Colors.green.shade400;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            const Text(
              "Payment Done Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            const Text(
              "You will be redirected to the home page shortly\nor click here to return to home page",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: VLButton(
                  textLabelButton: const Text("Go Home Page"),
                  colorTextLabelButton: Colors.white,
                  iconButton: const Icon(Icons.home_work_rounded),
                  colorButton: Colors.green,
                  iconColorButton: Colors.white,
                  onPress: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (c) => const AppScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
