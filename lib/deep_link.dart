import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;

import 'package:uni_links/uni_links.dart';

class DeepLink {
  DeepLink() {
    initUniLinks();
  }

  initUniLinks() async {
    try {
      String initLink = await getInitialLink();
      print(initLink);
    } on PlatformException {
      return;
    }
  }
}
