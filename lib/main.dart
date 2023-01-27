import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      title: 'PayCalculator_Brijen_133589200',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PayCalculator_Brijen_301271637'),
        ),
        body: const Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  CalculatorState createState() {
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator> {
  final _formKey = GlobalKey<FormState>();
  RegExp regexp = RegExp(r'^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  double numberOfHours = 0;
  double hoursRate = 0;
  double regularPay = 0;
  double overtimePay = 0;
  double totalPay = 0;
  double taxAmount = 0;
  double doublevalue = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 48.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter total hours',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter number of hours';
                      }
                      if (!regexp.hasMatch(value)) {
                        return 'Enter Valid Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      numberOfHours = double.parse(value!);
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter wage per hour',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter hourly rate';
                      }
                      if (!regexp.hasMatch(value)) {
                        return 'Enter Valid Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      hoursRate = double.parse(value!);
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      calculatePay();
                    }
                  },
                  child: const Text('Calculate'),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 40.0),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 20),
                        Text(
                          'Report',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        const Text(
                          'Regular Pay =',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '$regularPay',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          'Overtime Pay =',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '$overtimePay',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          'Total pay =',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '$totalPay',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          'Tax =',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          '$taxAmount',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
        AboutMe()
      ],
    );
  }

  calculatePay() {
    if (numberOfHours <= 40) {
      regularPay = numberOfHours * hoursRate;
      overtimePay = 0;
    } else {
      overtimePay = (numberOfHours - 40) * hoursRate * 1.5;
      regularPay = 40 * hoursRate;
    }
    totalPay = regularPay + overtimePay;
    taxAmount = totalPay * 0.18;
    setState(() {});
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.indigo),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            SizedBox(height: 5),
            Text(
              'Brijen Shah',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              'ID: 301271637',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
          ],
        ));
  }
}
