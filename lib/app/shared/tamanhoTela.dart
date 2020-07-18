import 'package:flutter/material.dart';

class TamanhoTela{
  double value;
  BuildContext context;
  TamanhoTela(this.value, this.context); 
  
  double get _tamanhoHeight => MediaQuery.of(context).size.height;
  double get _tamanhoWidth => MediaQuery.of(context).size.width;

  double converterHeight() => value * _tamanhoHeight; 
  double converterWidth() => value * _tamanhoWidth; 


}