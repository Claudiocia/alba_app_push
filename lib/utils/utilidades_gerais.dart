import 'dart:math';

import 'package:flutter/material.dart';


class UtilidadeGeral {
  UtilidadeGeral();

  gerarColor(){
    List colors = [
      Color(0xFF7D79D0),
      Color(0xFF8B0000),
      Color(0xFF008080),
      Color(0xFF8B4513),
      Color(0xFF0000FF),
      Color(0xFFFFD700),
    ];
    Random random = new Random();
    int index = 0;
    index = random.nextInt(6);

    return colors[index];
  }

  void showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  removeAcents(String text){
    List<String> semAcento = ["ç", "Ç", "á", "é", "í", "ó", "ú", "ý", "Á", "É",
      "Í", "Ó", "Ú", "Ý", "à", "è", "ì", "ò", "ù", "À", "È", "Ì", "Ò", "Ù", "ã",
      "õ", "ñ", "ä", "ë", "ï", "ö", "ü", "ÿ", "Ä", "Ë", "Ï", "Ö", "Ü", "Ã", "Õ",
      "Ñ", "â", "ê", "î", "ô", "û", "Â", "Ê", "Î", "Ô", "Û"];

    List<String> comAcento = ["c", "C", "a", "e", "i", "o", "u", "y", "A", "E",
      "I", "O", "U", "Y", "a", "e", "i", "o", "u", "A", "E", "I", "O", "U", "a",
      "o", "n", "a", "e", "i", "o", "u", "y", "A", "E", "I", "O", "U", "A", "O",
      "N", "a", "e", "i", "o", "u", "A", "E", "I", "O", "U"];

    for(int i =0; i < semAcento.length; i++){
      text = text.replaceAll(semAcento[i], comAcento[i]);
    }
    return text;
  }

}