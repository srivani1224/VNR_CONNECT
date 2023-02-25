// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vnr_connect/screens/clubs_studentchapters/after_login_organizer/desc.dart';

class ProviderClub {
  Widget mapFunction(String functionName) {
    switch (functionName) {
      case "LiveWireDesc":
        return Desc("Clubs/LiveWire");

      case "CrescendoDesc":
        return Desc("Clubs/Crescendo");

      case "CreativeArtsDesc":
        return Desc("Clubs/Creative Arts");

      case "VJTeatroDesc":
        return Desc("Clubs/VJTeatro");

      case "ScintillateDesc":
        return Desc("Clubs/Scintillate");

      case "StentorianDesc":
        return Desc("Clubs/Stentorian");

      case "SahitiVanamDesc":
        return Desc("Clubs/SahitiVanam");

      case "DramatrixDesc":
        return Desc("Clubs/Dramatrix");

      case "NArmyDesc":
        return Desc("Clubs/NArmyDesc");

      default:
        return Desc("Clubs/CreativeArts");
    }
  }
}
