import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../const.dart';
import '../data/TransactionCompany.dart';
import '../data/utility.dart';
import '../model/add_date.dart';
import '../widgets/headHomePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var history;
  final box = Hive.box<Add_data>('data');
  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'Friday',
    'Saturday',
    'Sunday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HeadHomePage(),
              ),
              SliverToBoxAdapter(
                child: HeadTransaction(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    history = box.values.toList()[index];
                    return ListTransaction(history, index);
                  },
                  childCount: box.length,
                ),
              )
            ],
          );
        },
      )),
    );
  }

  Widget ListTransaction(Add_data history, int index) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        history.delete();
      },
      child: CardTransaction(index, history),
    );
  }

  Card CardTransaction(int index, Add_data history) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            'assets/images/${history.name}.png',
            height: 40,
          ),
        ),
        title: Text(
          history.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          history.amount,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: history.IN == 'Income' ? Colors.greenAccent : Colors.red),
        ),
      ),
    );
  }
}

class HeadTransaction extends StatelessWidget {
  const HeadTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions History',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            Text(
              'See all',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
