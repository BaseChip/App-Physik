import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/beugungsmuster_plot_bloc.dart';
import '../widgets/widgets.dart';

class BeugungsmusterPlotPage extends StatelessWidget {
  const BeugungsmusterPlotPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beugungsmuster"),),
      body: buildbody(context),
    );
  }

  BlocProvider<BeugungsmusterPlotBloc> buildbody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BeugungsmusterPlotBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            /// TOP HALF - Plot Settings
            SizedBox(
              height: 10,
            ),
            PlotSettingControls(),
            /// BOTTOM HALF - Bild und Status
            // fügt einen Abstand von 10 über den Container, damit das Bild etwas platz hat
            SizedBox(
              height: 10,
            ),
            BlocBuilder<BeugungsmusterPlotBloc, BeugungsmusterPlotState>(
                builder: (context, state) {
                  //? Empty
                  if (state is BeugungsmusterPlotEmpty){
                   return ImageDisplay(filename: "basic.png");
                   //? Error
                  }else if (state is BeugungsmusterPlotError){
                    return MessageDisplay(message: state.error);
                    //? Loading
                  } else if (state is BeugungsmusterPlotLoading){
                    return LoadingDisplay();
                    //? Loaded
                  }else if(state is BeugungsmusterPlotLoaded){
                      // übergibt den von der Api zurpck gelieferten Dateinamen und zeigt den zugehörigen Plot an
                      return ImageDisplay(filename: state.filename.filename.toString());
                    //? keine Fall ist eigetreten, der eintreten sollte
                 }else{
                   return MessageDisplay(message: state.toString());
                 }
                },
              ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}