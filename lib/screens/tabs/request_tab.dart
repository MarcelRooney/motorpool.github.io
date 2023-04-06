import 'package:car_rental/services/add_req.dart';
import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/text_widget.dart';
import 'package:car_rental/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({super.key});

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  final nameController = TextEditingController();

  final addressController = TextEditingController();

  final destinationController = TextEditingController();

  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }

    final TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          timePicked.hour,
          timePicked.minute,
        );
      });
    }
  }

  String _selectedItem = 'Sedans';

  final List<String> _items = [
    "Sedans",
    "SUVs",
    "Vans",
    "Pickup trucks",
    "Military vehicles",
    "Motorcycles",
    "Buses",
    "Tractors",
    "Trailers",
    "Specialty vehicles",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 300, right: 300, top: 50, bottom: 50),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 250,
          width: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://umindanao.edu.ph/images/tour/AV2_7905.JPG'))),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                child: VerticalDivider(),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 375,
                  width: 300,
                  child: Column(
                    children: [
                      Center(
                        child: TextBold(
                            text: 'Request vehicle now!',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          label: 'Full name', controller: nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Address', controller: addressController),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextRegular(
                            text: 'Vehicle', fontSize: 12, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        width: 300,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButton<String>(
                            underline: Container(color: Colors.transparent),
                            value: _selectedItem,
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value!;
                              });
                            },
                            items: _items.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                          label: 'Destination',
                          controller: destinationController),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonWidget(
                          label: 'Submit',
                          onPressed: (() {
                            _selectDateTime(context).then((value) {
                              addReq(
                                  nameController.text,
                                  addressController.text,
                                  _selectedItem,
                                  destinationController.text,
                                  selectedDateTime);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: TextBold(
                                        text: 'Request sent succesfully!',
                                        fontSize: 18,
                                        color: Colors.white)),
                              );
                              nameController.clear();
                              destinationController.clear();
                              addressController.clear();
                            });
                          }))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
