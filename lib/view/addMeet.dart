import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mao3dd/firebace/addForm.dart';
import 'package:mao3dd/widget/showToast.dart';
import 'package:mao3dd/widget/snackBar.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../constants.dart';
import '../widget/InputField.dart';
import '../widget/fildTimer.dart';
import 'Home.dart';

class AddMeet extends StatefulWidget {
  const AddMeet({Key? key}) : super(key: key);

  @override
  State<AddMeet> createState() => _AddMeetState();
}

class _AddMeetState extends State<AddMeet> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();


  String? name;

  String? phone;

  String? dateTimeSelected;

  String?  dateDaySelected;

  String? resultTime;

  String? resultDay;

  int _selectedColor = 0;
  DocumentReference<Object?>? Id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: defaultBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          // ignore: deprecated_member_use
          leading: FlatButton(
            onPressed: () {
              Get.to( const HomeScreen(),duration:const Duration(seconds: 1,),transition: Transition.leftToRight);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'MAO3D',
            style: TextStyle(color: textColor),
          ),
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputField(
                  title: 'Name',
                  hint: 'Enter title here',
                  controller: _titleController,
                  onSavedForm: (value) {
                    name = value;
                  },
                ),
                InputField(
                  type: TextInputType.number,
                  title: 'Phone',
                  hint: 'Enter note here',
                  controller: _noteController,
                  onSavedForm: (value) {
                    phone = value;
                  },
                ),
                FildTimer(
                  ontap: () async {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            cancelText: null,
                            lastDate: DateTime(2032))
                        .then((value) {
                      value ??= DateTime.now();
                      setState(() {
                        resultDay= DateFormat.yMd().format(value!);
                        dateDaySelected = resultDay;
                      });
                    });
                  },
                  title: 'Day Time',
                  daysTime:
                      // ignore: unnecessary_null_comparison
                      dateDaySelected != null
                          ? dateDaySelected!
                          : DateFormat.yMd().format(DateTime.now()),
                  icons: Icons.calendar_today_outlined, widthSize: double.infinity,
                ),
                Row(
                  children: [
                    FildTimer(
                      ontap: () async {
                        final result = await TimePicker.show<DateTime?>(
                          context: context,
                          sheet: TimePickerSheet(
                            sheetTitle: 'Select meeting schedule',
                            minuteTitle: 'Minute',
                            hourTitle: 'Hour',
                            saveButtonText: 'Save',
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            resultTime= DateFormat('hh:mm a')
                                .format(result)
                                .toString();
                            dateTimeSelected = resultTime;
                          });
                        } else if (resultTime == null) {
                          showSnackBar(context, 'Plese Enter Date');
                        }
                      },
                      title: 'Meet Time',
                      // ignore: unnecessary_null_comparison
                      daysTime: dateTimeSelected != null
                          ? dateTimeSelected!
                          : DateFormat('hh:mm a').format(DateTime.now()).toString(),
                      icons: Icons.access_time_rounded,
                      widthSize: MediaQuery.of(context).size.width*0.43,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Color',
                              style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: textColorAddMeet)),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 14,right: 14),
                            margin: const EdgeInsets.only(top: 8),
                            width: MediaQuery.of(context).size.width*0.43,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Wrap(
                              children: List<Widget>.generate(
                                3,
                                    (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedColor = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: CircleAvatar(
                                      child: _selectedColor == index
                                          ? const Icon(Icons.done, size: 13, color: Colors.white)
                                          : null,
                                      backgroundColor: index == 0
                                          ? Colors.blue[300]
                                          : index == 1
                                          ? Colors.grey
                                          : Colors.orange,
                                      radius: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 16),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                      height: MediaQuery.of(context).size.height * 0.1,
                      minWidth: MediaQuery.of(context).size.height * 0.9,
                      onPressed: () {
                        if (name != null && phone != null && dateTimeSelected != null && dateDaySelected != null) {
                        AddForm().addUser(name, phone, dateTimeSelected, dateDaySelected,_selectedColor);

                          showToast('The information has been filled in successfully', Colors.green);
                            Get.to( const HomeScreen(), duration:const Duration(seconds: 1,),transition: Transition.leftToRight);
                        } else if (name == null || phone == null || dateTimeSelected == null || dateDaySelected == null) {

                          showToast('Please fill in the information', Colors.red);
                        } else {

                          showToast('Some Thing Have Error', Colors.yellow);
                        }

                      },
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        'ADD DATE',
                        style: TextStyle(color: textColorButton),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
