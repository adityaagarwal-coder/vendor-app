import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? taskStream;

  DatabaseServices databaseServices = new DatabaseServices();
  TextEditingController taskEdittingControler1 = new TextEditingController();
  TextEditingController taskEdittingControler2 = new TextEditingController();
  TextEditingController taskEdittingControler3 = new TextEditingController();

  get doc => null;
  @override
  void initState() {
    databaseServices.getTasks().then((val) {
      taskStream = val;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor App"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: taskEdittingControler1,
                    decoration: InputDecoration(hintText: "Name"),
                    onChanged: (text) {
                      taskEdittingControler1.text = text;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                taskEdittingControler1.text.isNotEmpty &&
                        taskEdittingControler2.text.isNotEmpty &&
                        taskEdittingControler3.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Map<String, dynamic> taskMap = {
                            "Name": taskEdittingControler1.text,
                            "Image": taskEdittingControler2.text,
                            "Price": taskEdittingControler3.text,
                          };
                          databaseServices.createTask(taskMap);
                          taskEdittingControler1.text = "";
                          taskEdittingControler2.text = "";
                          taskEdittingControler3.text = "";
                        },
                        child: Container(child: Text("UPLOAD PRODUCT")))
                    : Container()
              ]),
              Row(children: [
                Expanded(
                  child: (TextField(
                      controller: taskEdittingControler2,
                      decoration: InputDecoration(hintText: "Image link"),
                      onChanged: (text) {
                        taskEdittingControler2.text = text;
                        setState(() {});
                      })),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: (TextField(
                      controller: taskEdittingControler3,
                      decoration: InputDecoration(hintText: "Price"),
                      onChanged: (text) {
                        taskEdittingControler3.text = text;
                        setState(() {});
                      })),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
