import 'package:course/sitting/logs.dart';
import 'package:course/sitting/logssqflitedb.dart';
import 'package:course/sitting/student.dart';
import 'package:course/sitting/studentsqflitedb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  final DBLogsManager dbStudentManager = DBLogsManager();
  DBActionLogsManager dbActionLogsManager = DBActionLogsManager();

//  List<ActionLogs>? studlist;
  List<Logs>? actionlog;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: FutureBuilder(
        future: dbActionLogsManager.getLogList(),
        //dbStudentManager.getStudentList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              //studlist = snapshot.data as List<ActionLogs>?;
              actionlog = snapshot.data as List<Logs>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: actionlog == null ? 0 : actionlog!.length,
                //studlist == null ? 0 : studlist!.length,
                itemBuilder: (BuildContext context, int index) {
                  //ActionLogs st = studlist![index];
                  Logs st = actionlog![index];
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: width * 0.50,
                            child: Column(
                              children: <Widget>[
                                Text('ID: ${st.id}'),
                                Text("username: ${st.username}"),
                                Text('Name: ${st.actionname}'),
                                Text('Action Date: ${st.date}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Text(
                'No Data',
                style: TextStyle(fontSize: 40),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
