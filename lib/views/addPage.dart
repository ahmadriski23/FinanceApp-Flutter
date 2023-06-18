import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:status_alert/status_alert.dart';

import '../const.dart';
import '../model/add_date.dart';
import '../widgets/bottomBar.dart';
import 'homePage.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final box = Hive.box<Add_data>('data');

  DateTime date = DateTime.now();
  String? selectedItemName;
  String? selectedItemType;

  final TextEditingController explainController = TextEditingController();
  FocusNode ex = FocusNode();

  final TextEditingController amountController = TextEditingController();
  FocusNode focusAmount = FocusNode();

  final List<String> _item = [
    'Food',
    'Transfer',
    'Transportation',
    'Education',
    'Fashion'
  ];

  final List<String> _itemType = [
    'Income',
    'Expand',
  ];

  @override
  void initState() {
    super.initState();
    ex.addListener(() {
      setState(() {});
    });
    focusAmount.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          BackgroundContainer(context),
          Positioned(
            child: MainContainer(),
          )
        ],
      )),
    );
  }

  Padding MainContainer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 80, 40, 80),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                DropdownAddName(),
                SizedBox(
                  height: 30,
                ),
                TextFieldAddExplain(),
                SizedBox(
                  height: 30,
                ),
                TextFieldAddAmount(),
                SizedBox(
                  height: 30,
                ),
                DropdownAddIncomeExpand(),
                SizedBox(
                  height: 30,
                ),
                AddDateTime(),
                SizedBox(
                  height: 60,
                ),
                SaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding SaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          var add = Add_data(selectedItemType!, amountController.text, date,
              explainController.text, selectedItemName!);
          box.add(add);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomBarWidget()));
          StatusAlert.show(
            context,
            duration: Duration(seconds: 2),
            title: 'Success',
            subtitle: 'Your  Transactions is Success!!',
            configuration: IconConfiguration(icon: Icons.done),
            maxWidth: 350,
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: kPrimaryColor),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Text(
            'Save',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  Widget AddDateTime() {
    return GestureDetector(
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100));
        if (newDate == null) return;
        setState(() {
          date = newDate;
        });
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffc5c5c5),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100));
            if (newDate == Null) return;
            setState(() {
              date = newDate!;
            });
          },
          child: Text(
            'Date : ${date.year} / ${date.day} / ${date.month}',
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ),
    );
  }

//Function
  Container DropdownAddIncomeExpand() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Color(0xffc5c5c5),
        ),
      ),
      child: DropdownButton<String>(
        value: selectedItemType,
        underline: SizedBox(),
        items: _itemType
            .map(
              (e) => DropdownMenuItem(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  value: e),
            )
            .toList(),
        selectedItemBuilder: (BuildContext context) => _itemType
            .map((e) => Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 16),
                  ),
                ))
            .toList(),
        hint: Text(
          'How',
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        onChanged: ((value) {
          setState(() {
            selectedItemType = value!;
          });
        }),
      ),
    );
  }

  TextFormField TextFieldAddAmount() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Oopss , Your amount its empty';
        } else {
          return null;
        }
      },
      focusNode: focusAmount,
      controller: amountController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Amount',
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffc5c5c5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: kPrimaryColor,
            ),
          )),
    );
  }

  TextFormField TextFieldAddExplain() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Oopss , Your explain its empty';
        } else {
          return null;
        }
      },
      focusNode: ex,
      controller: explainController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Explain',
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffc5c5c5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: kPrimaryColor,
            ),
          )),
    );
  }

  Container DropdownAddName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Color(0xffc5c5c5),
        ),
      ),
      child: DropdownButton<String>(
        value: selectedItemName,
        underline: SizedBox(),
        items: _item
            .map(
              (e) => DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          child: Image.asset('assets/images/${e}.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  value: e),
            )
            .toList(),
        selectedItemBuilder: (BuildContext context) => _item
            .map((e) => Container(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        child: Image.asset('assets/images/${e}.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        e,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ))
            .toList(),
        hint: Text(
          'Name',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        onChanged: ((value) {
          setState(() {
            selectedItemName = value!;
          });
        }),
      ),
    );
  }

  Column BackgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                    Text(
                      'Adding',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
