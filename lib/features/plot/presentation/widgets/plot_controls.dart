import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/beugungsmuster_plot_bloc.dart';

class PlotSettingControls extends StatefulWidget {
  const PlotSettingControls({
    Key key,
  }) : super(key: key);

  @override
  _PlotSettingControlsState createState() => _PlotSettingControlsState();
}

class _PlotSettingControlsState extends State<PlotSettingControls> {
  String inputSpaltanzahl = "2";
  String inputSpaltabstand = "1.0";
  String inputWellenlaenge = "2.0";
  String inputAmplitude = "1.0";

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "Splatanzahl:",
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                inputSpaltanzahl = value;
              },
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodyText1.color),
              decoration: InputDecoration(
                hintText: "2",
                hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "Spaltabstand:",
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                inputSpaltabstand = value;
              },
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodyText1.color),
              decoration: InputDecoration(
                hintText: "1.0",
                hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "Wellenlänge:",
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                inputWellenlaenge = value;
              },
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodyText1.color),
              decoration: InputDecoration(
                hintText: "2.0",
                hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "Amplitude:",
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                inputAmplitude = value;
              },
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodyText1.color),
              decoration: InputDecoration(
                hintText: "1.0",
                hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
              ),
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text(
                "Erzeuge Plot",
                style: Theme.of(context).primaryTextTheme.button,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                createPlot();
              },
            ),
          ),
        ],
      ),
    ]);
  }

  void createPlot() {
    BlocProvider.of<BeugungsmusterPlotBloc>(context).add(
        GetPlotForBeugungsmuster(inputSpaltanzahl, inputSpaltabstand,
            inputWellenlaenge, inputAmplitude));
  }
}
