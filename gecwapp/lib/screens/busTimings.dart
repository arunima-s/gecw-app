import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_scraper/web_scraper.dart';

class BusTiming extends StatefulWidget {
  @override
  BusTimingState createState() => BusTimingState();
}

//Classes

class BusTimingState extends State<BusTiming> {
  final ksrtcUrl = WebScraper('https://www.aanavandi.com');
  List<Map<String, dynamic>>? busNames;
  List<Map<String, dynamic>>? departure;
  List<Map<String, dynamic>>? arrival;

  void fetchTimings() async {
    // Loads web page and downloads into local state of library
    if (await ksrtcUrl.loadWebPage(
        '//search/results/source/trivandrum/destination/kottayam-bs-(ktm)/timing/morning')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        busNames = ksrtcUrl.getElement(
            // 'div.thumbnail > div.caption > h4 > a.title', ['href', 'title']);
            'div.timings > div.schedule',
            []);
        departure = ksrtcUrl.getElement(
            // 'div.thumbnail > div.caption > h4 > a.title', ['href', 'title']);
            'div.timings > div.departure',
            []);
        arrival = ksrtcUrl.getElement(
            // 'div.thumbnail > div.caption > h4 > a.title', ['href', 'title']);
            'div.timings > div.arrival',
            []);
        // productDescriptions = webScraper.getElement(
        //     'div.thumbnail > div.caption > p.description', ['class']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("***************************");
    // Requesting to fetch before UI drawing starts
    fetchTimings();
  }

  @override
  Widget build(BuildContext context) {
    var count = busNames?.length;

    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Product Catalog'),
          ),
          body: SafeArea(
              child: busNames == null || departure == null || arrival == null
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Loads Circular Loading Animation
                    )
                  // : DataTable(columns: [
                  //   DataColumn(label: Text("Route")),
                  //   DataColumn(label: Text("Departure")),
                  //   DataColumn(label: Text("Arrival"))
                  // ], rows: [

                  // ])
                  : ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        // Attributes are in the form of List<Map<String, dynamic>>.
                        String place = busNames![index]['title'];
                        String dep = departure![index]['title'];
                        String arr = arrival![index]['title'];

                        List<Map<String, dynamic>>? edited;
                        for (var i = 0; i < count!; i++) {}

                        return BusTimingRow(place, dep, arr);
                      }))),
    );
  }
}

class BusTimingRow extends StatelessWidget {
  final String _busName, _departureTime, _arrivalTime;

  BusTimingRow(this._busName, this._departureTime, this._arrivalTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Text(_busName),
          ),
          Container(
            child: Text(_departureTime),
          ),
          Container(
            child: Text(_arrivalTime),
          )
        ],
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

//Dummy class starts

class WebScraperApp extends StatefulWidget {
  @override
  _WebScraperAppState createState() => _WebScraperAppState();
}

class _WebScraperAppState extends State<WebScraperApp> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://webscraper.io');

  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>>? productNames;
  late List<Map<String, dynamic>> productDescriptions;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper
        .loadWebPage('/test-sites/e-commerce/allinone/computers/laptops')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        productNames = webScraper.getElement(
            'div.thumbnail > div.caption > h4 > a.title', ['href', 'title']);
        productDescriptions = webScraper.getElement(
            'div.thumbnail > div.caption > p.description', ['class']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Product Catalog'),
          ),
          body: SafeArea(
              child: productNames == null
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Loads Circular Loading Animation
                    )
                  : ListView.builder(
                      itemCount: productNames!.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("-*-----------------------");
                        print(productNames);
                        print("++++++++++++++++++++++");
                        print(productDescriptions);
                        print("-*-----------------------");
                        // Attributes are in the form of List<Map<String, dynamic>>.
                        Map<String, dynamic> attributes =
                            productNames![index]['attributes'];

                        print(attributes);
                        print('******************');
                        print(attributes['title']);
                        return Text(attributes['title']);
                        // return Text(productDescriptions[index]['title']);

                        // return ExpansionTile(
                        //   title: Text(attributes['title']),
                        //   children: <Widget>[
                        //     Padding(
                        //       padding: const EdgeInsets.all(10.0),
                        //       child: Column(
                        //         children: <Widget>[
                        //           Container(
                        //             child: Text(
                        //                 productDescriptions[index]['title']),
                        //             margin: EdgeInsets.only(bottom: 10.0),
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               // uses UI Launcher to launch in web browser & minor tweaks to generate url
                        //               launch(webScraper.baseUrl! +
                        //                   attributes['href']);
                        //             },
                        //             child: Text(
                        //               'View Product',
                        //               style: TextStyle(color: Colors.blue),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     )
                        //   ],
                        // );
                      }))),
    );
  }
}
