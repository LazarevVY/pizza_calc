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

enum PizzaSize { small, medium , large }
enum PizzaDough { ordinary , slim }
enum PizzaSauce { hot, sweet_and_sour , cheese }


class _PizzaCalcState extends State<PizzaCalc> {
  PizzaSize?  _size = PizzaSize.medium;
  PizzaDough? _dough = PizzaDough.ordinary;
  PizzaSauce? _sauce = PizzaSauce.sweet_and_sour;
  bool        _additionalCheese = true;
  int         _priceTotal = 0;
  
  int _getPrice () {
    const int _costDefault = 400;
    int _price = 0;
    var _costSize = {
      PizzaSize.small : 20,
      PizzaSize.medium : 40,
      PizzaSize.large: 60
    };
    var _costDough = {
      PizzaDough.ordinary : 0,
      PizzaDough.slim : 30
    };
    var _costSauce = {
      PizzaSauce.hot : 10,
      PizzaSauce.sweet_and_sour : 20,
      PizzaSauce.cheese: 40
    };
    var _costAdditionalCheese = {
      true : 50,
      false: 0
    };
    _price =  _costDefault;
    _price += _costSize[_size] ?? 0;
    _price += _costDough[_dough] ?? 0;
    _price += _costSauce[_sauce] ?? 0;
    _price += _costAdditionalCheese[_additionalCheese] ?? 0;
    return _price;
    }
  void _onSauceChanged (PizzaSauce? value) {
    setState(() {
      _sauce = value;
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
      onChanged: (bool value){},
      onTap: (){},
      onDoubleTap: (){},
      onSwipe: (){},
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/pizza_bg_1.jpg",
                  ),
                  opacity: 0.1,
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                const SizedBox( height: 16),
                SizedBox (
                  child: Image.asset("assets/images/pizza.png")
                ),
                //const SizedBox( height: 6),
                const Text("Калькулятор пиццы",
                style: TextStyle(fontSize: 36,
                ),),
                const Text("Выберите параметры:",
                  style: TextStyle(fontSize: 16,
                  ),),
                const SizedBox( height: 6),
                _SlidingSwitch(),

                const SizedBox( height: 16,
                  child: Text("Размер",

                  ),
                ),
                Slider(value: 0,
                    onChanged: (double value){}),
                const SizedBox( height: 6),


              ],
            ),
          ),
      ),
    );
  }
}
