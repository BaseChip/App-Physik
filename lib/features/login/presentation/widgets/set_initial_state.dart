import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physik_lp_app_rewrite/features/login/presentation/bloc/login_bloc.dart';

void setInitialEvent(BuildContext blocContext) {
  BlocProvider.of<LoginBloc>(blocContext).add(UserInitialEvent());
}
