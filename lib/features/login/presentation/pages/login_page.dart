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
import '../widgets/textfield.dart';
import 'create_account_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String lEmail, lPw;
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
                padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                child: Text(
                  "Login",
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                child: LoginTextField(text: "Email:", from: this),
              ),
              LoginTextField(
                text: "Password:",
                from: this,
                obsure_text: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: LoginButton(
                  text: "Login",
                  from: this,
                ),
              ),
              Opacity(
                child: RaisedButton(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountPage()));
                  },
                  child: Text(
                    "Ich habe noch keinen Account",
                    style: Theme.of(blocContext).primaryTextTheme.bodyText1,
                  ),
                ),
                opacity: 0.42,
              ),
              buildbloc2(context)
            ],
          ),
        ));
  }

  void ButtonAction() {
    if (lEmail != null && lPw != null) {
      BlocProvider.of<LoginBloc>(blocContext)
          .add(LoginUserEvent(email: lEmail, pw: lPw));
    }
  }

  set email(String email) {
    setState(() {
      lEmail = email;
    });
  }

  set pw(String pw) {
    setState(() {
      lPw = pw;
    });
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

                /// Wenn das anmelden erfolgreich war, wird der neue Auth Key
                /// gespeichert und der Nutzer wieder auf den HomeScreen
                /// weitergeleitet
              } else if (state is LoginSuccessfull) {
                sl<SharedPrefsAuth>().auth_key = state.authkey.auth_key;
                sl<SharedPrefsAuth>().logedin = true;
                SuccessDisplayFlushbar()
                    .showSuccessFlushbar(context, "Erfolgreich angemeldet");
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
