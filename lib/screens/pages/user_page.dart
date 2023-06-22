import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/events/app_event.dart';
import 'package:e_commerce_app/events/auth_event.dart';
import 'package:e_commerce_app/models/history_model.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isReadOnly = true;

  int maND = 0;
  String ho = "";
  String ten = "";
  String gioiTinh = "";
  String sdt = "";
  String email = "";
  String diaChi = "";

  int numberOrders = 0;
  List<HistoryModel> allHistoriesList = [];
  bool isShowHistories = false;

  static late SharedPreferences sharedPreferences;

  Future<void> getInfoUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    maND = int.parse(sharedPreferences.getString("MaND")!);

    await AuthEvent().getDetailUser(maND).then((value) {
      ho = value.ho;
      ten = value.ten;
      gioiTinh = value.gioiTinh;
      sdt = value.sdt;
      email = value.email;
      diaChi = value.diaChi;
    });

    setState(() {
      firstNameController.text = ho;
      lastNameController.text = ten;
      genderController.text = gioiTinh;
      phoneNumberController.text = sdt;
      emailController.text = email;
      addressController.text = diaChi;
    });
  }

  getOrderHistories() async {
    sharedPreferences = await SharedPreferences.getInstance();
    maND = int.parse(sharedPreferences.getString("MaND")!);
    var result = await fetchAllHistories(maND);
    setState(() {
      allHistoriesList = result;
      numberOrders = allHistoriesList.length;
    });
  }

  @override
  initState() {
    getInfoUser();
    getOrderHistories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getInfoUser,
      child: Scaffold(
        backgroundColor: VLColors.vlBackgroundColor,
        appBar: AppBar(
          backgroundColor: VLColors.vlBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: VLColors.vlMainColor,
              child: IconButton(
                  onPressed: () => setState(
                        () {
                          isReadOnly = true;
                        },
                      ),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: IconButton(
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    AuthEvent authEvent = AuthEvent();
                    authEvent.signOutAction(context, mounted);
                  },
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Image.asset(
                        "assets/images/user.png",
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  isReadOnly
                      ? Column(
                          children: [
                            Text(
                              '$ho $ten',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buildButton(context, '$numberOrders', 'Orders', () {
                                  if (isShowHistories == true) {
                                    isShowHistories = false;
                                  } else {
                                    isShowHistories = true;
                                  }
                                  setState(() {});
                                }),
                                buildDivider(),
                                buildButton(context, '35', 'Following', () {}),
                                buildDivider(),
                                buildButton(context, '50', 'Followers', () {}),
                              ],
                            ),
                            const SizedBox(height: 24),
                            //code show/hide history
                            isShowHistories
                                ? Column(
                                    children: allHistoriesList
                                        .map((e) => Card(
                                              color: e.trangThai == "1" ? Colors.green : Colors.white,
                                              margin: const EdgeInsets.all(10),
                                              elevation: 6,
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.only(left: 24, top: 10, bottom: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Order ID: ",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: e.maHD,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Receiver Name: ",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: e.nguoiNhan,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Time Order: ",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: e.ngayLap,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Receiver Phone: ",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: e.sdt,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Receiver Address: ",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: e.diaChi,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Total Amount: ",
                                                          style: const TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: e.tongTien,
                                                              style: const TextStyle(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  )
                                : const SizedBox(height: 4),
                            const SizedBox(
                              height: 4,
                            ),
                            //continue code information here.
                            Card(
                              color: Colors.white,
                              elevation: 6,
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                subtitle: Text(
                                  gioiTinh,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: const SizedBox(
                                  height: double.infinity,
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                                title: const Text("Gender"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              elevation: 6,
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                subtitle: Text(
                                  sdt,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: const SizedBox(
                                  height: double.infinity,
                                  child: Icon(
                                    Icons.phone_android_rounded,
                                  ),
                                ),
                                title: const Text("Phone"),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              elevation: 6,
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                subtitle: Text(
                                  diaChi,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: const SizedBox(
                                  height: double.infinity,
                                  child: Icon(
                                    Icons.location_city_rounded,
                                  ),
                                ),
                                title: const Text("Address"),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.abc_rounded),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Enter your first name',
                                  labelText: "First Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.abc_rounded),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Enter your last name',
                                  labelText: "Last Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: genderController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Enter your gender',
                                  labelText: "Gender",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email_rounded),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Enter your email',
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.phone_android_rounded),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Enter your phone',
                                  labelText: "Phone",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.maps_home_work_rounded),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Enter your address',
                                  labelText: "Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                  isReadOnly
                      ? Container(
                          margin: const EdgeInsets.all(8),
                          child: VLButton(
                            textLabelButton: const Text('EDIT'),
                            colorTextLabelButton: Colors.white,
                            iconButton: const Icon(Icons.edit_note_rounded),
                            colorButton: Colors.red,
                            iconColorButton: Colors.white,
                            onPress: () {
                              setState(() {
                                isReadOnly = false;
                              });
                            },
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(8),
                          child: VLButton(
                            textLabelButton: const Text("UPDATE"),
                            colorTextLabelButton: Colors.white,
                            iconButton: const Icon(Icons.check_rounded),
                            colorButton: Colors.green,
                            iconColorButton: Colors.white,
                            onPress: () {
                              AuthEvent().updateUserAction(
                                maND,
                                firstNameController.text,
                                lastNameController.text,
                                genderController.text,
                                emailController.text,
                                phoneNumberController.text,
                                addressController.text,
                                context,
                                mounted,
                                setState(
                                  () {
                                    getInfoUser();
                                    isReadOnly = true;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDivider() => Container(
        height: 24,
        width: 2,
        color: Colors.black,
      );

  Widget buildButton(BuildContext context, String value, String text, VoidCallback onPress) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: onPress,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
