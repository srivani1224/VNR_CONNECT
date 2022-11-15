// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs/creative_arts/creative_arts_desc.dart';
import 'package:vnr_connect/screens/clubs/crescendo/crescendo_desc.dart';
import 'package:vnr_connect/screens/clubs/dramatrix/dramatrix_desc.dart';
import 'package:vnr_connect/screens/clubs/live_wire/live_wire_desc.dart';
import 'package:vnr_connect/screens/clubs/n_army/n_army_desc.dart';
import 'package:vnr_connect/screens/clubs/sahiti_vanam/sahiti_vanam_desc.dart';
import 'package:vnr_connect/screens/clubs/scintillate/scintillate_desc.dart';
import 'package:vnr_connect/screens/clubs/stentorian/stentorian_desc.dart';
import 'package:vnr_connect/screens/clubs/vj_teatro/vj_teatro_desc.dart';

class ProviderClub {
  Widget mapFunction(String functionName) {
    switch (functionName) {
      case "LiveWireDesc":
        return LiveWireDesc();

      case "CrescendoDesc":
        return CrescendoDesc();

      case "CreativeArtsDesc":
        return CreativeArtsDesc();

      case "VJTeatroDesc":
        return VJTeatroDesc();

      case "ScintillateDesc":
        return ScintillateDesc();

      case "StentorianDesc":
        return StentorianDesc();

      case "SahitiVanamDesc":
        return SahitiVanamDesc();

      case "DramatrixDesc":
        return DramatrixDesc();

      case "NArmyDesc":
        return NArmyDesc();

      default:
        return NArmyDesc();
    }
  }
}
