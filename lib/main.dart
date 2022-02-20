import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(
   MaterialApp(
       debugShowCheckedModeBanner: false, //hide debug banner
        home: Main())
  );
}

class Main extends StatefulWidget{
  MainState createState()=>MainState();
}
class MainState extends State<Main>{

  String funfact ="";
  String fact ="";

  //to ru=>
  String rufunfact="";
  String rufact="";

  //to kyr=>
  String kyrfunfact="";
  String kyrfact="";
  //to kor=>
  String korfunfact="";
  String korfact="";
  //to pol=>
  String polfunfact="";
  String polfact="";

  Future<http.Response> GenerateFunFact() async {
    //clear data =>
    funfact="";
    fact="";
    rufunfact="";
    rufact="";
    korfunfact="";
    korfact="";
    polfunfact="";
    polfact="";
    kyrfact="";
    kyrfunfact="";
    //work with translator=>
    final translator = GoogleTranslator();

    final response1 = await http.get(Uri.parse("https://asli-fun-fact-api.herokuapp.com/"));
    String res = response1.body.toString();
    Map<String, dynamic> jsonmap = jsonDecode(res);
    String data ='${jsonmap['data']}';
    int pos_fact = data.indexOf("fact");
    int pos_cat = data.indexOf("cat");
    String datatransfer = data.substring(pos_fact+6,pos_cat-2);
    funfact = "English : "+data.substring(pos_fact+6,pos_cat-2);
    //translate our data to ru=>
    var translationru = await translator.translate(datatransfer, to: 'ru');
    var translationky = await translator.translate(datatransfer, to: 'ky');
    var translationko = await translator.translate(datatransfer, to: 'ko');
    var translationpl = await translator.translate(datatransfer, to: 'pl');

    rufunfact = "Russian (Русский) : $translationru";
    kyrfunfact ="Kyrgyz (Кыргызча) : $translationky";
    korfunfact ="Korean (한국어) : $translationko";
    polfunfact = "Polish (Polski) : $translationpl";
    return response1;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.only(left: 20 , right: 20),
              child: SizedBox(width: width-40, height: 60,
                child: Text("Welcome user , here is new fun fact for you" ,
                  style: GoogleFonts.comicNeue(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black))
                ,textAlign: TextAlign.center,
                )),
              ),
            Padding(padding: EdgeInsets.only(left: 20,right: 20),
              child: Container(width: width-40, height: height*0.8,
                alignment: Alignment.center,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: width-40, height: height*0.15,
                      child: Text(fact ,
                          style: GoogleFonts.comicNeue(textStyle: const
                          TextStyle(fontSize: 24, color: Colors.black)), textAlign: TextAlign.center,)
                    ),
                    SizedBox(width: width-40, height: height*0.15,
                        child: Text(kyrfunfact,
                          style: GoogleFonts.comicNeue(textStyle: const
                          TextStyle(fontSize: 24, color: Colors.black)), textAlign: TextAlign.center,)
                    ),
                    SizedBox(width: width-40, height: height*0.15,
                        child: Text(rufunfact ,
                          style: GoogleFonts.comicNeue(textStyle: const
                          TextStyle(fontSize: 24, color: Colors.black)), textAlign: TextAlign.center,)
                    ),
                    SizedBox(width: width-40, height: height*0.15,
                        child: Text(korfact ,
                          style: GoogleFonts.comicNeue(textStyle: const
                          TextStyle(fontSize: 24, color: Colors.black)), textAlign: TextAlign.center,)
                    ),
                    SizedBox(width: width-40, height: height*0.15,
                        child: Text(polfact,
                          style: GoogleFonts.comicNeue(textStyle: const
                          TextStyle(fontSize: 24, color: Colors.black)), textAlign: TextAlign.center,)
                    ),
                    SizedBox(width: width*0.55, height: height*0.05,
                    child:
                    ElevatedButton(
                        onPressed: () async {
                          // Generate fun fact =>
                           await GenerateFunFact().then((value) => setState(() {
                                  fact = funfact;
                                  rufact = rufunfact;
                                  kyrfact = kyrfunfact;
                                  korfact = korfunfact;
                                  polfact = polfunfact;
                           }));
                          //update screen =>
                        },
                        child: Text("Generate fun fact" ,
                            style: GoogleFonts.comicNeue(textStyle: const
                            TextStyle(fontSize: 18, color: Colors.white))),
                        style:ElevatedButton.styleFrom(primary: Color.fromRGBO(192, 192, 255, 1))
                    ))
                  ],
                )
              )
              ,)
          ],
      ),
    );
  }

}