import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'change_rate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyExchange(),
    );
  }
}

final TextEditingController AmountValue = TextEditingController();

class CurrencyExchange extends StatefulWidget {
  CurrencyExchange({super.key});

  @override
  State<CurrencyExchange> createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  Widget? TotalValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Image.asset("assets/icons/floos.png", width: 94,height: 94,),
                SizedBox(width: 150,),
                Text("Floos", style: TextStyle(color: Color(0xFF2AAAF1), fontSize: 40, fontFamily: "Roboto"),)
              ],
            ),
            SizedBox(
              height: 120,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("From Currency:", style: TextStyle(color: Colors.white, fontSize: 19),),
                    Container(
                      padding: EdgeInsets.only(left: 7,top: 5),
                      color: Color(0xFF2C2C2C),
                      width: 170,
                      height: 60,

                      child: DropDownFromCurrency(),
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To Currency:", style: TextStyle(color: Colors.white, fontSize: 19),),
                    Container(
                      padding: EdgeInsets.only(left: 7,top: 5),
                      color: Color(0xFF2C2C2C),
                      width: 170,
                      height: 60,
                      child:  DropDownToCurrency(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: 200,
              height: 50,
              color: Color(0xFF2C2C2C),
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9.]'),
                  ),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                controller: AmountValue,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            TotalValue != null ? TotalValue as Widget : Text(""),
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF2C2C2C)),
                  ),
                  onPressed: ()
                  {
                    setState(() {
                      TotalValue = calculateTotal();
                    });
                  },
                  child: Text("Exchange",style: TextStyle(color: Colors.white, fontSize: 20),)
              ),
            ),
            SizedBox(height: 250,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 250,
                  height: 100,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF2C2C2C))),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangeRate()),
                        );
                      }, child: Row(
                        
                        children: [
                          Text("Change Rates",style: TextStyle(color: Colors.white, fontSize: 20),),
                          SizedBox(width: 20,),
                          Icon(Icons.arrow_forward, size: 50, color: Colors.white,),
                        ],
                      )
                  ),
                ),
                SizedBox(width: 20,),
              ],
            )

          ],
        ),
      ),
    );;
  }
}

final List<Map<String, dynamic>> currencies= [
  {"name" : "LBP", "icon": "assets/icons/lbp.png","rate": 89584.0},
  {"name" : "USD", "icon": "assets/icons/usa.png","rate": 0.0},
  {"name" : "AUD", "icon": "assets/icons/australia.png","rate": 1.55},
  {"name" : "CAD", "icon": "assets/icons/canada.png","rate": 1.41},
  {"name" : "CHF", "icon": "assets/icons/switzerland.png","rate": 0.81}
];
String? ToCurrency;
String? FromCurrency;

class DropDownToCurrency extends StatefulWidget {
  const DropDownToCurrency({super.key});

  @override
  State<DropDownToCurrency> createState() => _DropDownState();
}

class _DropDownState extends State<DropDownToCurrency> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: ToCurrency,
      hint: Text(""),
      underline: SizedBox(),
      dropdownColor: Color(0xFF2C2C2C),
      isExpanded: true,
      items: currencies.map((currency){
        return DropdownMenuItem<String>(
          value: currency["name"],
          child: Row(
            children: [
              Image.asset(currency["icon"], width: 44, height: 44,),
              SizedBox(width: 20,),
              Text(currency["name"], style: TextStyle(color: Colors.white, fontSize: 20),),
            ],
          ),
        );
      }).toList(),
      onChanged: (c){
        setState(() {
          ToCurrency = c;
        });
      },
    );
  }
}

class DropDownFromCurrency extends StatefulWidget {
  const DropDownFromCurrency({super.key});

  @override
  State<DropDownFromCurrency> createState() => _DropDownFromCurrencyState();
}

class _DropDownFromCurrencyState extends State<DropDownFromCurrency> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownButton<String>(

        value: FromCurrency,

        underline: SizedBox(),
        dropdownColor: Color(0xFF2C2C2C),
        isExpanded: true,
        items: currencies.map((currency){
          return DropdownMenuItem<String>(
            value: currency["name"],
            child: Row(
              children: [
                Image.asset(currency["icon"], width: 44, height: 44,),
                SizedBox(width: 20,),
                Text(currency["name"], style: TextStyle(color: Colors.white, fontSize: 20),),
              ],
            ),
          );
        }).toList(),
        onChanged: (c){
          setState(() {
          FromCurrency = c;
          });
        },
      ),
    );
  }
}

Widget calculateTotal()
{


  if(ToCurrency == null || FromCurrency==null || AmountValue.text.isEmpty)
    {
      return Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
          child: Text("Fill in all fields", style: TextStyle(color: Colors.red, fontSize: 30),)
      );
    }
  else
    {
      double Value = double.parse(AmountValue.text);
      double valueToCurrency = 0.0;
      double valueFromCurrency = 0.0;
      double total;
      currencies.forEach((element)
      {
        if(element["name"] == ToCurrency)
          {
            valueToCurrency = element["rate"];
          }
        if(element["name"] == FromCurrency)
          {
            valueFromCurrency = element["rate"];
          }
      }
      );
      if(FromCurrency != "USD" && ToCurrency != "USD") {
        total = (Value/ valueFromCurrency) * valueToCurrency;
      } else if(FromCurrency == "USD") {
        total = Value * valueToCurrency;
      }
      else {
        total = Value / valueFromCurrency;
      }
      return Container(
          padding: EdgeInsets.only(top: 30, bottom: 30,),
          child: Text("Total: ${total.toStringAsFixed(2)} $ToCurrency", style: TextStyle(color: Colors.white,fontSize: 30),)
      );
    }
}

