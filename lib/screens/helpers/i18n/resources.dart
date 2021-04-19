import 'package:flutter/widgets.dart';

import 'strings/en_us.dart';
import 'strings/pt_br.dart';
import 'strings/translations.dart';

class R {

  static Translations string = PtBr();

  static void load(Locale locale){
    switch(locale.toString()){
      case 'en_US': string = EnUs(); break;
      default: string = PtBr(); break;
    }
  }

}