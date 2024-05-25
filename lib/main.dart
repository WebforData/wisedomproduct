import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:wisedomproduct/ProductDataModel.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: readJsonData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(child: Text("${data.error}"));
        } else if (data.hasData) {
          var items = data.data as List<ProductDataModel>;
          return ListView.builder(
              itemCount: items == null ? 0 : items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(items[index].title ?? 'Unknown title'),
                                  Text(
                                      'Item Location: ${items[index].itemLocation ?? 'Unknown location'}'),
                                  Text(
                                      'Seller Name: ${items[index].sellerName ?? 'Unknown seller name'}'),
                                  Text(
                                      'Returns: ${items[index].returns ?? 'Unknown returns'}'),
                                  Text(
                                      'Shipping: ${items[index].shipping ?? 'Unknown shipping'}'),
                                  Text(
                                      'Delivery: ${items[index].delivery ?? 'Unknown delivery'}'),
                                  Text(
                                      'Condition: ${items[index].condition ?? 'Unknown condition'}'),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height:
                                    16), // Add some spacing between product details and buttons
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _launchURL(
                                            Uri.parse(items[index].url ?? ''));
                                      },
                                      child: const Text('Go to Product'),
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Add some spacing between buttons
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        8), // Add some spacing between buttons and price badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Price: ${items[index].price ?? 'Unknown price'}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<List<ProductDataModel>> readJsonData() async {
    final jsondata = await rootBundle.rootBundle.loadString('data.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => ProductDataModel.fromJson(e)).toList();
  }

  Future<void> _launchURL(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        : throw 'could_not_launch_this_app';
  }
}
