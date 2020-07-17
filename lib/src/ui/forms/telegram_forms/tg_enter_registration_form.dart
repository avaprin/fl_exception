import 'package:flexception/src/blocs/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EnterRegister extends StatefulWidget {
  EnterRegister({Key key}) : super(key: key);

  @override
  _EnterRegisterState createState() => _EnterRegisterState();
}

class _EnterRegisterState extends State<EnterRegister> {
  MainBloc _mainBloc;
  String number = "+375";
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainBloc = BlocProvider.of<MainBloc>(context);
  }

  void _onCountryChange(CountryCode countryCode) {
    //TODO : manipulate the selected country code here
    print("New Country selected: " + countryCode.dialCode);
    setState(() {
      number=countryCode.dialCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SvgPicture.asset(
            'icons/telegram.svg',
            width: 35,
            height: 35,
          ),
          title: Text(
            "Telegram",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Color.fromRGBO(0, 145, 200, 1),
        ),
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Вход',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Пожалуйста, введите полный номер телефона',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(158, 168, 174, 1),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CountryCodePicker(
                          initialSelection: 'BY',
                          onChanged: _onCountryChange,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 200,
                          height: 25,
                          child: TextFormField(
                            controller: numberController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(46, 168, 227, 1),
                            blurRadius: 10.0,
                            // has the effect of softening the shadow
                            //spreadRadius: 10.0, // has the effect of extending the shadow
                            offset: Offset(0, 4))
                      ],
                      color: Color.fromRGBO(46, 168, 227, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        _mainBloc.dispatch(ToTelegramSecond(number+numberController.text));
                      },
                      textColor: Colors.white,
                      disabledTextColor: Colors.white54,
                      child: const Text('Далее',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Source Sans pro')),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Регистрация',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Введите ваши данные',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(158, 168, 174, 1),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Имя',
                            style: TextStyle(),
                          ),
                          SizedBox(width: 20),
                          Container(
                            width: 200,
                            height: 20,
                            child: TextFormField(),
                          ),
                        ],
                      )),
                  Container(
                    width: 300,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Фамилия',
                          style: TextStyle(),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 200,
                          height: 20,
                          child: TextFormField(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CountryCodePicker(
                          initialSelection: 'BY',
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 200,
                          height: 25,
                          child: TextFormField(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(46, 168, 227, 1),
                            blurRadius: 10.0,
                            // has the effect of softening the shadow
                            //spreadRadius: 10.0, // has the effect of extending the shadow
                            offset: Offset(0, 4))
                      ],
                      color: Color.fromRGBO(46, 168, 227, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () {},
                      textColor: Colors.white,
                      disabledTextColor: Colors.white54,
                      child: const Text('Далее',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Source Sans pro')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
