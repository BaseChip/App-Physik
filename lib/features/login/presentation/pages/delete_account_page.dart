import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/widgets/error_display.dart';
import '../../../../core/ui/widgets/success_display.dart';
import '../../../../core/util/shared_prefrences/shared_prefs_auth.dart';
import '../../../../injection_container.dart';
import '../bloc/login_bloc.dart';
import '../widgets/button.dart';
import '../widgets/dialog_account.dart';
import '../widgets/invisible_widget.dart';
import '../widgets/set_initial_state.dart';
import 'create_account_page.dart';

class DeleteAccount extends StatefulWidget {
  DeleteAccount({Key key}) : super(key: key);

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    blocContext = context;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AccountDialog(),
                barrierDismissible: true);
          },
          child: Icon(Icons.info),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 95, 15, 0),
                child: Text(
                  "Account / Daten löschen",
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
                child: Text(
                  "Bist du dir sicher, dass du deinen Account löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden und alle deine Daten werden von unseren Servern unwiderruflich gelöscht",
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: LoginButton(
                  text: "Löschen",
                  from: this,
                ),
              ),

              /// Würde bei der Seite eigtl nicht benötigt werden, ist beim debugen für mich aber sehr nützlich
              Opacity(
                child: RaisedButton(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountPage()));
                  },
                ),
                opacity: 0.0,
              ),
              buildbloc2(context)
            ],
          ),
        ));
  }

  void buttonAction() {
    if (sl<SharedPrefsAuth>().logedin) {
      BlocProvider.of<LoginBloc>(blocContext)
          .add(DeleteUserEvent(authkey: sl<SharedPrefsAuth>().authKey));
    } else {
      ErrorDisplayFlushbar().showErrorFlushbar(context,
          "Du bist nicht angemeldet, daher haben wir auch keine Daten von dir gespeichert. Falls du einen Account hast und den löschen möchstes, melde dich bitte erst an und versuche es dann erneut");
    }
  }

  BlocProvider<LoginBloc> buildbloc2(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Column(
        children: <Widget>[
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                blocContext = context;
              });
              if (state is LoginLoading) {
                return CircularProgressIndicator(
                  strokeWidth: 2,
                );
              } else if (state is LoginError) {
                ErrorDisplayFlushbar().showErrorFlushbar(context, state.error);
                setInitialEvent(context);

                /// Wenn das löschen erfolgreich war, wird der auth key gelöscht
                /// und der Nutzer wieder auf den HomeScreen weitergeleitet
              } else if (state is DeleteSuccess) {
                sl<SharedPrefsAuth>().authKey = null;
                sl<SharedPrefsAuth>().logedin = false;
                SuccessDisplayFlushbar().showSuccessFlushbar(
                    context, "Account erfolgreich gelöscht");
                setInitialEvent(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              }
            });
            return InvisibleWidget();
          })
        ],
      ),
    );
  }
}
