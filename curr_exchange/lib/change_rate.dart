import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

final TextEditingController rateValue = TextEditingController();
class ChangeRate extends StatefulWidget {
  const ChangeRate({super.key});

  @override
  State<ChangeRate> createState() => _ChangeRateState();
}

class _ChangeRateState extends State<ChangeRate> {
  Widget? myText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10,),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF1E1E1E)),overlayColor: MaterialStateProperty.all((Colors.transparent))),
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/floos.png", width: 94,height: 94,),),

              SizedBox(width: 150,),
              Text("Floos", style: TextStyle(color: Color(0xFF2AAAF1), fontSize: 40, fontFamily: "Roboto"),)
            ],
          ),
          Row(
            children: [
              SizedBox(width: 60,height: 350,),
              Container(
                padding: EdgeInsets.only(left: 7,top: 5),
                color: Color(0xFF2C2C2C),
                width: 170,
                height: 60,

                child: DropDownChangeRates(),
              ),
              SizedBox(width: 80,),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 200,
                height: 60,
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
                  controller: rateValue,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
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
                    myText = change_rate();
                    if(myText == null)
                      {
                        Navigator.pop(context);
                      }

                  });
                },
                child: Text("Change Rate",style: TextStyle(color: Colors.white, fontSize: 20),)
            ),
          ),
          myText != null ? (myText as Widget) : Text(""),
        ],
      ),
    );
  }
}

String? currencyToChange;
class DropDownChangeRates extends StatefulWidget {
  const DropDownChangeRates({super.key});

  @override
  State<DropDownChangeRates> createState() => _DropDownChangeRatesState();
}

class _DropDownChangeRatesState extends State<DropDownChangeRates> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownButton<String>(
        value: currencyToChange,
        underline: SizedBox(),
        dropdownColor: Color(0xFF2C2C2C),
        isExpanded: true,
        items: currencies
            .where((currency) => currency["name"] != "USD")
            .map((currency){
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
            currencyToChange = c;
          });
        },
      ),
    );
  }
}

dynamic change_rate()
{
  // currencyToChange
  // rateValue
  if(currencyToChange != null && rateValue.text != ""){
    for(int i = 0;i < currencies.length; i++){
      if(currencies[i]["name"] == currencyToChange)
        {
          currencies[i]["rate"] = double.parse(rateValue.text);
          break;
        }
    }
  }
  else
    {
      return Text("Fill in all fields!", style: TextStyle(color: Colors.red, fontSize: 20),);
    }
}



