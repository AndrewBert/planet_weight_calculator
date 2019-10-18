import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final TextEditingController controller = new TextEditingController();

  double result = 0;
  String selectedPlanet = "";
  String dropDownValue = "Venus";
  String userWeight = "0";

  Map<String, double> planets = {"Venus": 0.78, "Mars": 0.39, "Jupiter": 2.65, "Saturn": 1.17, "Uranus": 1.05, "Neptune": 1.23};

  updateWeight(String planetName, double gravity){
    if(planetName == dropDownValue){
      double calc = double.parse(userWeight) * gravity;
      result = num.parse(calc.toStringAsFixed(3));
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Planet Weight Calculator"),
        backgroundColor: Colors.deepPurple,
      ),
      body: new Container(
        child: new Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new DropdownButton<String>(
                    icon: Icon(Icons.arrow_downward),
                    value: dropDownValue,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    isExpanded: true,
                    onChanged: (String newValue){
                      setState(() {
                        dropDownValue = newValue;
                        planets.forEach((planetName, gravity) =>
                        {
                          updateWeight(planetName, gravity)
                        });

                      });
                    },
                    items: planets.keys
                    .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                new TextField(
                  decoration: new InputDecoration(
                    hintText: "Enter your weight: "
                  ),
                  style: new TextStyle(fontSize: 20.0),
                  onSubmitted: (String str){
                    setState(() {
                      userWeight = str;
                      planets.forEach((planetName, gravity) => {
                        updateWeight(planetName, gravity)
                      }
                      );

                    });
                  },
                ),
                  new Text("Your weight on $dropDownValue: $result", style: new TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
