import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  String firstname;
  String lastname;
  int age;
  String selectedGender;
  bool _isOption1 = false;
  bool _isOption2 = false;
  bool _isOption3 = false;
  List<String> selectedOptions = [];
  void _onRadioButtonChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์ม"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("ชื่อจริง"),
                TextFormField(
                  // initialValue: "อดุลวิทย์",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'กรอกชื่อ',
                  ),
                  initialValue: "",
                  // onChanged: (value) => print(value),
                  onSaved: (value) => setState(() {
                    firstname = value;
                  }),
                ),
                Text("นามสกุล"),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกนามสกุล';
                    }
                    return null;
                  },
                  // initialValue: "Hello",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'กรอกนามสกุล',
                  ),
                  initialValue: "",
                  // onChanged: (value) => print(value),
                  onSaved: (value) => setState(() {
                    lastname = value;
                  }),
                ),
                Text("อายุ"),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                  // initialValue: "Hello",
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'กรอกอายุ',
                  ),
                  initialValue: "",
                  // onChanged: (value) => print(value),
                  onSaved: (value) => setState(() {
                    try {
                      age = int.parse(value);
                    } catch (e) {
                      age = 0;
                    }
                  }),
                ),
                Text("เพศ"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ชาย'),
                    Radio(
                        value: 'ชาย',
                        groupValue: selectedGender,
                        onChanged: (value) => _onRadioButtonChange(value)),
                    Text('หญิง'),
                    Radio(
                        value: 'หญิง',
                        groupValue: selectedGender,
                        onChanged: (value) => _onRadioButtonChange(value)),
                  ],
                ),
                Text("อาการป่วย"),
                Column(
                  children: [
                    CheckboxListTile(
                      title: Text("ไอ"),
                      value: _isOption1,
                      onChanged: (value) {
                        setState(
                          () {
                            _isOption1 = !_isOption1;
                            if (_isOption1) {
                              selectedOptions.add("ไอ");
                            } else {
                              selectedOptions.remove("ไอ");
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                Column(
                  children: [
                    CheckboxListTile(
                      title: Text("เจ็บคอ"),
                      value: _isOption2,
                      onChanged: (value) {
                        setState(
                          () {
                            _isOption2 = !_isOption2;
                            if (_isOption2) {
                              selectedOptions.add("เจ็บคอ");
                            } else {
                              selectedOptions.remove("เจ็บคอ");
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                Column(
                  children: [
                    CheckboxListTile(
                      title: Text("มีไข้"),
                      value: _isOption3,
                      onChanged: (value) {
                        setState(
                          () {
                            _isOption3 = !_isOption3;
                            if (_isOption3) {
                              selectedOptions.add("มีไข้");
                            } else {
                              selectedOptions.remove("มีไข้");
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(firstname);
                        print(selectedGender);
                        print('Save');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Page2(
                              // description: firstname,
                              firstname: firstname,
                              lastname: lastname,
                              age: age,
                              gender: selectedGender,
                              menu: selectedOptions,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("บันทึก"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2(
      {Key key,
      this.firstname,
      this.lastname,
      this.age,
      this.gender,
      this.menu})
      : super(key: key);

  final String firstname;
  final String lastname;
  final int age;
  final String gender;
  final List<String> menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายงาน"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Column(
            //   children: menu.map((e) => Text(e)).toList(),
            // ),
            // Container(
            //   child: Text(gender),
            // ),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Coronavirus_cartoon.svg/1200px-Coronavirus_cartoon.svg.png"),
            ),
            covidDetect(menu),
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ย้อนกลับ"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('คุณหมอไม่ว่าง')));
        },
        icon: Icon(Icons.call),
        label: Text('โทรหาคุณหมอ'),
      ), //
    );
  }

  Widget covidDetect(List<String> symtoms) {
    if (symtoms.length == 3) {
      return Container(
        width: 300,
        height: 300,
        child: Center(
          child: Text("คุณ $firstname $lastname อายุ $age ปี เป็นโควิด"),
        ),
      );
    } else {
      return Container(
        width: 300,
        height: 300,
        child: Center(
          child: Text("คุณ $firstname $lastname อายุ $age ปี ไม่เป็นโควิด"),
        ),
      );
    }
  }
}
