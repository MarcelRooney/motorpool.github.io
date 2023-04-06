import 'package:car_rental/screens/about_us.dart';
import 'package:car_rental/screens/admin/admin_map.dart';
import 'package:car_rental/screens/admin/admin_record.dart';
import 'package:car_rental/screens/admin/admin_req.dart';
import 'package:car_rental/screens/tabs/notif_tab.dart';
import 'package:car_rental/screens/tabs/request_tab.dart';
import 'package:car_rental/screens/vehicles_screen.dart';
import 'package:car_rental/utils/constant.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  final UserType? userType;

  const HomeScreen({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    // final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
    // .collection('User')
    // .doc(FirebaseAuth.instance.currentUser!.uid)
    // .snapshots();
    return DefaultTabController(
      length: 2,
      child: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    opacity: 150.0,
                    image: AssetImage('assets/images/back.png'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          Image.asset(
                            'assets/images/profile.png',
                            height: 120,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 500,
                            child: TextBold(
                                text:
                                    'Physical Plant Maintenance Unit Motorpool Department',
                                fontSize: 28,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 400,
                            child: TabBar(
                                labelStyle: const TextStyle(
                                    fontFamily: 'QBold', fontSize: 15),
                                tabs: [
                                  const Tab(
                                    text: 'Request',
                                  ),
                                  Tab(
                                    text: userType == UserType.user
                                        ? 'Notification'
                                        : 'Record',
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        child: TabBarView(children: [
                          userType == UserType.user
                              ? const RequestTab()
                              : const AdminRequest(),
                          userType == UserType.user
                              ? const NotifTab()
                              : const AdminRecord()
                        ]),
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AboutUsPage()));
                                },
                                child: TextBold(
                                    text: 'About us',
                                    fontSize: 18,
                                    color: Colors.white)),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VehiclesScreen()));
                                },
                                child: TextBold(
                                    text: 'Our vehicles',
                                    fontSize: 18,
                                    color: Colors.white)),
                            userType != UserType.user
                                ? TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AdminMap()));
                                    },
                                    child: TextBold(
                                        text: 'Map of Vehicles',
                                        fontSize: 18,
                                        color: Colors.white))
                                : const SizedBox(),
                            TextButton(
                                onPressed: () async {
                                  const buksu = 'https://buksu.edu.ph/';
                                  if (await canLaunch(buksu)) {
                                    await launch(buksu);
                                  } else {
                                    throw 'Could not launch $buksu';
                                  }
                                },
                                child: TextBold(
                                    text: 'University Link',
                                    fontSize: 18,
                                    color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
