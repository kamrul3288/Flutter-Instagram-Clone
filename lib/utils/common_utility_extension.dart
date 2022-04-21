

import 'package:flutter/cupertino.dart';

extension TextFromTextEditingController on TextEditingController{
  String toText(){
    return this.text.toString().trim();
  }
}