import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkScreen extends StatelessWidget {
  // const LinkScreen({Key? key}) : super(key: key);

  final dataset = {""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),
                Text(
                  "Useful Links",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

            // physics: ClampingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 20);
            },
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return LinkWidget(index);
            },
          ),
        ],
      ),
    );
  }
}

class LinkWidget extends StatelessWidget {
  final dataset = {
    "ETLab": " https://gecwyd.etlab.in/user/login",
    "KTU Portal": "https://app.ktu.edu.in/login.htm",
    "Results": "https://app.ktu.edu.in/eu/res/viewExamStudentResults.htm",
    "College Portal": "https://www.gecwyd.ac.in/"
  };
  final int index;
  LinkWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launch(dataset.values.elementAt(index),
            forceSafariVC: true, forceWebView: true, enableJavaScript: true);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 5, 45, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dataset.keys.elementAt(index)),
            Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
