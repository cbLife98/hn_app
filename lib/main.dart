import 'package:flutter/material.dart';
import 'src/country.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Country App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Country> _country = countries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: new RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 5));
          setState(() {
            _country.removeAt(0);
          });
        },
        child: ListView(
          children: _country.map(_buildItem).toList(),
        ),
      ),

    );
  }

  Widget _buildItem(Country country) {
    return Padding(
      key: Key(country.tld),
      padding: const EdgeInsets.all(16.0),
      child: new ExpansionTile(
          title: new Text(country.name,style: new TextStyle(fontSize:24.0 ),),
          children: <Widget>[
            new Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("${country.capital}"),
                  new IconButton(
                    icon: new Icon(Icons.launch),
                      onPressed: () async{
                        final url = country.flag;
                           if(await canLaunch(url)) {
                             launch(url);
                           }
                      },
                  )
                ],
            ),
          ],
      ),
    );
  }
}
