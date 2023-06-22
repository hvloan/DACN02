import 'package:e_commerce_app/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VLColors.vlBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "SETTINGS",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: VLColors.vlBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Card(
                color: Colors.white,
                elevation: 6,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  subtitle: Text(
                    "HePhoneShop Profile",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  leading: SizedBox(
                    height: double.infinity,
                    child: Icon(
                      Icons.error_rounded,
                    ),
                  ),
                  title: Text(
                    "Introduction",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.navigate_next_rounded),
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  subtitle: Text(
                    "Contact HePhoneShop",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  leading: SizedBox(
                    height: double.infinity,
                    child: Icon(
                      Icons.contact_support,
                    ),
                  ),
                  title: Text(
                    "Contact",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.navigate_next_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
