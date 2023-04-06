import 'package:car_rental/screens/home_screen.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../data/vehicles.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff6571E0),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {}),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff6571E0),
        title: const Text(
          'Our Vehicles',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'QBold',
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 150.0,
            image: AssetImage('assets/images/back.png'),
          ),
        ),
        child: GridView.builder(
            itemCount: cars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 20,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Image.network(
                            cars[index].imageUrl,
                            height: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextBold(
                              text: cars[index].model,
                              fontSize: 18,
                              color: Colors.black),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBold(
                              text: 'Year: ${cars[index].year.toString()}',
                              fontSize: 12,
                              color: Colors.black),
                          const SizedBox(
                            height: 10,
                          ),
                          TextBold(
                              text: 'Made by: ${cars[index].make.toString()}',
                              fontSize: 12,
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
