import 'package:carousel_slider/carousel_slider.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:helpme_app/Widgets/CustomDrawer.dart';

final List<String> imgList = [

  'https://static.mundodasmensagens.com/upload/textos/n/a/nao-desista-ja-pois-o-caminho-que-leva-ao-sucesso-tem-varias-etap-3nvxJ-w.jpg',
  'https://mensagens.culturamix.com/blog/wp-content/gallery/2_30/frases-para-combater-a-depressao-5.jpg',
  'https://vidadevinicius.files.wordpress.com/2013/07/esforca-te-e-tem-bom-animo.jpg',
  'https://www.42frases.com.br/wp-content/uploads/2019/09/nao-importa-onde-e-nem.png',
  'https://static.mundodasmensagens.com/upload/textos/a/s/as-vezes-a-tristeza-invade-o-meu-coracao-sem-aviso-vem-mas-com-fo-kdbvz-cxl.jpg',
  'https://www.belasmensagens.com.br/wp-content/uploads/2017/11/se-hoje-esta-dificil.jpg',
];


final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(

  imgList,

  (index, i) {

    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(i, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {

  List<T> result = [];


  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override

  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();

}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;


  @override
  Widget build(BuildContext context) {

    return Column(children: [
      CarouselSlider(

        items: child,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 38.0,
              height: 38.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();

    //Manually operated Carousel
    final CarouselSlider manualCarouselDemo = CarouselSlider(
      items: child,
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(252, 239, 246, 1),
        appBar: GradientAppBar(
          title: Text('Mensagens para Você'),
          centerTitle: true,
          backgroundColorStart: Color.fromRGBO(165, 88, 157, 1),
          backgroundColorEnd: Color.fromRGBO(119, 1, 108, 1),
        ),

        drawer: CustomDrawer(_pageController),

        body: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(children: [
                  Text(''),
                  manualCarouselDemo,
                ])),
          ],
        ),
      ),

    );

  }
}
