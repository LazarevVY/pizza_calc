import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';


void main() {
  runApp ( const PizzaCalc() );
}

class PizzaCalc extends StatefulWidget {
  const PizzaCalc({Key? key}) : super(key: key);

  @override
  _PizzaCalcState createState() => _PizzaCalcState();
}
// Параметры пиццы задаются в виде перечислений для того,
// чтобы упростить вычисления конечной стоимости продукта в функции _getPrice
enum PizzaSize { small, medium , large }
enum PizzaDough { ordinary , slim }
enum PizzaSauce { hot, sweet_and_sour , cheese }


class _PizzaCalcState extends State<PizzaCalc> {

// Ниже и далее аннотации типов включены для наглядности учебного материала.
// Если нет надобности их отображать, то вместо аннотации можно использовать var
  final  Map<bool, PizzaDough> _doughMap = {
    false: PizzaDough.ordinary,
    true:  PizzaDough.slim
  };
  final Map<int, PizzaSize> _sizeMap = {
    1 : PizzaSize.small,
    2 : PizzaSize.medium,
    3 : PizzaSize.large,
  };
  final _sizeLabelMap = {
    1: "20 см",
    2: "40 см",
    3: "60 см"
  };
  final _sizeSliderLabelMap = {
    1: "малая",
    2: "средняя",
    3: "большая"
  };
  PizzaSize?   _size             = PizzaSize.medium;
  double       _sizeSlider       = 1.0;
  String?      _sizeLabel        = "20 см";
  String?      _sliderLabel      = "малая";
  PizzaDough?  _dough            = PizzaDough.ordinary;
  PizzaSauce?  _sauce            = PizzaSauce.sweet_and_sour;
  bool         _additionalCheese = true;
  int          _priceTotal       = 490;
  final String _currency          = "руб.";
  
  int _getPrice () {
    const int _costDefault      = 400;
          int _price            = 0;
//        Ингридиент            : стоимость
    final Map<PizzaSize, int> _costSize = {
      PizzaSize.small           : 20,
      PizzaSize.medium          : 60,
      PizzaSize.large           : 100
    };
    final Map<PizzaDough, int> _costDough = {
      PizzaDough.ordinary       : 0,
      PizzaDough.slim           : 30
    };
    final Map<PizzaSauce, int> _costSauce = {
      PizzaSauce.hot            : 10,
      PizzaSauce.sweet_and_sour : 20,
      PizzaSauce.cheese         : 40
    };
    final Map<bool, int> _costAdditionalCheese = {
      true                      : 50,
      false                     : 0
    };
    _price =  _costDefault;
    _price += _costSize [ _size  ] ?? 0;
    _price += _costDough[ _dough ] ?? 0;
    _price += _costSauce[ _sauce ] ?? 0;
    _price += _costAdditionalCheese[_additionalCheese] ?? 0;
    return _price;
    }


  void _onSauceChanged (PizzaSauce? value) {
    setState(() {
      _sauce      = value;
      _priceTotal = _getPrice();
    });
  }

  void _onDoughChanged (bool value) {
    setState(() {
      _dough      = _doughMap [value];
      _priceTotal = _getPrice();
    });
  }

  void _onSizeChanged (double value) {
    setState(() {
      _sizeSlider = value;
      _size       = _sizeMap      [_sizeSlider.toInt()];
      _sizeLabel  = _sizeLabelMap [_sizeSlider.toInt()];
      _sliderLabel = _sizeSliderLabelMap [_sizeSlider.toInt()].toString();
      _priceTotal = _getPrice();
    });
  }

  void _onCheeseChanged (bool value) {
    setState(() {
      _additionalCheese = value;
      _priceTotal = _getPrice();
    });
  }

  Widget _SlidingSwitch (){
    return SlidingSwitch(
      textOff: "Обычное тесто",
      textOn: "Тонкое тесто",
      value: false,
      width: 300, height: 28,
      colorOn: Colors.white,
      colorOff: Colors.white,
      buttonColor: Colors.blue,
      onChanged: _onDoughChanged,
      onTap: (){},
      onDoubleTap: (){},
      onSwipe: (){},
    );
  }
  BoxDecoration _background (){
    return const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/pizza_bg_1.jpg",
    ),
    opacity: 0.1,
    fit: BoxFit.cover),
    );
  }
  Widget _additionalCheeseWidget () {
    return SizedBox(
      width: 300,
      child: Card (
        color: Color (0xfff0f0f0),
        shape: RoundedRectangleBorder (
          borderRadius: BorderRadius.circular(10)),
        child: Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only( right: 20 ),
              child: SizedBox(
                width: 38, height: 56,
                child: Image.asset("assets/images/cheese_2.jpg"))),
            const Text("Дополнительный сыр",
                style: TextStyle(fontSize: 16, color: Color(0xff263238))),
            Switch(value: _additionalCheese, onChanged: _onCheeseChanged )
          ],
        ),
      )
    );
  }
  Widget _sizeSelect () {
    return SizedBox(
      width: 300,
      child: Row (
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 150,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: const Text( "Размер:",
                        style: TextStyle (fontSize: 16, color: Color(0xff000000)),
                      ),
                    ),
                    Container(
                      width: 150,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Text( "${_sizeLabel}",
                        style: TextStyle (fontSize: 16, color: Color(0xff000000),
                        fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Slider(
                      label: _sliderLabel,
                      value: _sizeSlider,
                      divisions: 2,
                      min: 1,
                      max: 3,
                      onChanged: _onSizeChanged,
                    ),
                  ],
                ),
              ],
            ),
          ]
      ),
    );
  }

  Widget _makeOrder () {
    return SizedBox(
        width: 154, height: 42,
        child: ElevatedButton(onPressed: (){}, child: Text("Заказать"),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF0079D0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0)
            ),
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.grey,
          body: Container(
            width: double.infinity,
            decoration: _background(),
            child: Column(
              children: [
                //const SizedBox( height: 6),
                SizedBox (
                  height: 200,
                  child: Image.asset("assets/images/pizza.png")
                ),
                //const SizedBox( height: 6),
                const Text("Калькулятор пиццы",
                style: TextStyle(fontSize: 36,
                ),),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: const Text( "Выберите параметры:",
                  style: TextStyle (fontSize: 16, color: Color(0xff000000)),
                ),
              ),
                const SizedBox( height: 6),
                _SlidingSwitch(),
                _sizeSelect(),

                const SizedBox( height: 6),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: const Text( "Соус:",
                    style: TextStyle (fontSize: 16, color: Color(0xff000000)),
                  ),
                ),
                RadioListTile(
                    title: const Text("Острый"),
                    value: PizzaSauce.hot,
                    groupValue: _sauce,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -3.0),
                    onChanged: _onSauceChanged
                    ),
                RadioListTile(
                    title: const Text("Кисло-сладкий"),
                    value: PizzaSauce.sweet_and_sour,
                    groupValue: _sauce,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -3.0),
                    onChanged: _onSauceChanged
                ),
                RadioListTile(
                    title: const Text("Сырный"),
                    value: PizzaSauce.cheese,
                    groupValue: _sauce,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -3.0),
                    onChanged: _onSauceChanged
                ),
                _additionalCheeseWidget(),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: const Text( "Стоимость:",
                    style: TextStyle (fontSize: 24, color: Color(0xff000000)),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Card(
                      color:  Color(0xfff0f0f0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    child: Text("${_priceTotal} ${_currency}",
                      style: TextStyle(fontSize: 32, color: Color(0xff000000)),
                      textAlign: TextAlign.center),
                    ),
                ),
                SizedBox(height: 10),
                _makeOrder(),
              ],
            ),
          ),
      ),
    );
  }

}
