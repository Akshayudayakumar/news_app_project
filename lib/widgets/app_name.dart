import 'package:flutter/material.dart';
import 'package:news_app_project/widgets/text_builder.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
TextBuilder(text:'NEWS',fontSize: 40,color:Color(0xFF16C47F),fontWeight: FontWeight.w700,),
TextBuilder(text:'HUNT',fontSize: 40,color:Colors.black,fontWeight: FontWeight.w700,),
      ],
    );
  }
}
