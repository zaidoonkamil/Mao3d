import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mao3dd/widget/showToast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';

import '../constants.dart';
import '../firebace/addForm.dart';
import 'addMeet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: defaultBackgroundColor,
          drawer: Drawer(
            backgroundColor: Colors.white,
            elevation: 0,
            child: Column(
              children: [
                const DrawerHeader(
                  child: Icon(
                    Icons.favorite,
                    size: 64,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: tilePadding,
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: appBarColor,
                      ),
                      title: Text(
                        'D A S H B O A R D',
                        style: drawerTextColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Share.share('check out my website https://example.com', subject: 'Look what I made!');

                  },
                  child: Padding(
                    padding: tilePadding,
                    child: ListTile(
                      leading: Icon(
                        Icons.share,
                        color: appBarColor,
                      ),
                      title: Text(
                        'S H A R E',
                        style: drawerTextColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                        title: 'M A O 3 D',
                        titleStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        content: Text(
                          'dfokdifjioefckfapdlkopakdofofffafesafiehfi,oijiuhyughyuyugtyftrsdfcvyfgtyfytftyftydrrtdctdtdtdtdtdtddtrdresrthjtftyj',
                          style: TextStyle(color: Colors.grey[900]),
                        ));
                  },
                  child: Padding(
                    padding: tilePadding,
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: appBarColor,
                      ),
                      title: Text(
                        'A B O U T',
                        style: drawerTextColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                   if( Platform.isAndroid)
                     {
                       SystemNavigator.pop();
                     }else{exit(0);}
                  },
                  child: Padding(
                    padding: tilePadding,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: appBarColor,
                      ),
                      title: Text(
                        'E X I T',
                        style: drawerTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title: Text(
              'MAO3D',
              style: TextStyle(color: textColor),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width:MediaQuery.of(context).size.height * 0.26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        // ignore: deprecated_member_use
                        child: FlatButton(
                         onPressed: () {
                              Get.to(const AddMeet());
                            },
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              'CREATE DATE',
                              style: TextStyle(color: textColorButton),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: StreamBuilder(
              stream: AddForm().getDataStream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return showToast('Something Went Wrong', Colors.red)
                      as Widget;
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                final data = snapshot.requireData;
                return ListView.separated(
                    itemCount: data.size,
                    itemBuilder: (context, index) {

                      return Slidable(
                          startActionPane:  const ActionPane(dragDismissible: false,
                            motion: DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: doNothink,
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                              SlidableAction(
                                onPressed: doShare,
                                backgroundColor: Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: 'Share',
                              ),
                            ],
                          ),
                          key: const ValueKey(0),
                          child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: getBGClr(data.docs[index]['color']),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_sharp,
                                                color: IconColorHome,
                                              ),
                                              Text(
                                                '  Name: ${data.docs[index]['name']}',
                                                style:
                                                TextStyle(color: textColor),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time_outlined,
                                                color: IconColorHome,
                                              ),
                                              Text(
                                                '  Day Time:  ${data.docs[index]['Day Time']}',
                                                style:
                                                TextStyle(color: textColor),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_alarm,
                                                color: IconColorHome,
                                              ),
                                              Text(
                                                '  Time Stated:  ${data.docs[index]['Meet Time']}',
                                                style:
                                                TextStyle(color: textColor),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8,
                                          right: 3,
                                          left: 5),
                                      child: Container(
                                        height: double.infinity,
                                        width: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 6.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Text('Dr.Ali Ahmed',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      );


                    },
                  separatorBuilder: (BuildContext context, int index) {return const Padding(
                      padding: EdgeInsets.only(top: 8.0,bottom: 8),
                      child: SizedBox(),
                    ); },);
              },
            ),
      ),
    );

  }

}

