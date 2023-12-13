import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  Color myColor = Colors.grey.shade300;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  var mainResult = TextEditingController();

  void calculateBMI(String weight, String height) {
    var myDoubleWeight = double.parse(weight);
    var myDoubleHeight = double.parse(height);
    var res = myDoubleWeight / (myDoubleHeight * myDoubleHeight);

    setState(() {
      mainResult.text = res.toStringAsFixed(2);
      if (res < 18.5) {
        myColor = Color(0xFF87B1D9);
      } else if (res >= 18.5 && res <= 24.9) {
        myColor = Color(0xFF3DD365);
      } else if (res >= 25 && res <= 29.9) {
        myColor = Color(0xFFEEE133);
      } else if (res >= 30 && res <= 34.9) {
        myColor = Color(0xFFFD802E);
      } else if (res >= 35) {
        myColor = Color(0xFFF95353);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Scale Smart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              buildInputField(
                controller: weightController,
                hint: "Enter your weight (kg)",
                icon: Icons.monitor_weight,
              ),
              SizedBox(height: 20),
              buildInputField(
                controller: heightController,
                hint: "Enter your height (m)",
                icon: Icons.height,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  calculateBMI(weightController.text, heightController.text);
                },
                child: Text("Calculate"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40),
              BMIResultBox(color: myColor, result: mainResult.text),
              SizedBox(height: 20),
              BMIResultLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
      {required TextEditingController controller,
      required String hint,
      required IconData icon}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class BMIResultBox extends StatelessWidget {
  final Color color;
  final String result;

  const BMIResultBox({Key? key, required this.color, required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "BMI: $result",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class BMIResultLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem('Underweight', Color(0xFF87B1D9)),
        _buildLegendItem('Normal', Color(0xFF3DD365)),
        _buildLegendItem('Overweight', Color(0xFFEEE133)),
        _buildLegendItem('Obese', Color(0xFFFD802E)),
        _buildLegendItem('Extreme', Color(0xFFF95353)),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Column(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(height: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
