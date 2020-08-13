import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:physik_lp_app_rewrite/core/util/shared_prefrences/shared_prefs_cdots.dart';

import '../../../../../injection_container.dart';

class CDotSetting extends StatefulWidget {
  CDotSetting({Key key}) : super(key: key);

  @override
  _CDotSettingState createState() => _CDotSettingState();
}

class _CDotSettingState extends State<CDotSetting> {
  bool _value = sl<SharedPrefsCDots>().cDotsSetting;
  @override
  Widget build(BuildContext context) {
    return ListTileSwitch(
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          sl<SharedPrefsCDots>().cDotsSetting = value;
        },
        switchActiveColor: Theme.of(context).accentColor,
        title: Text(
          "CDots",
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ));
  }
}
