import 'package:flutter/material.dart';

class Characteristics extends StatelessWidget{
  final List<int> percentage;

  Characteristics({required this.percentage});

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:List.generate(5, (index) {
        return _buildCharacteristicsItem(index);
      })
    );
  }


  Widget _buildCharacteristicsItem(int index) {
    var color;
    var icon;

    switch(index){
      case 0:
        color = Colors.green;
        icon = Icons.landscape;
      case 1:
        color = Colors.brown;
        icon = Icons.fort;
      case 2:
        color = Colors.blue;
        icon = Icons.palette;
      case 3:
        color = Colors.red;
        icon = Icons.restaurant;
      case 4:
        color = Colors.orange;
        icon = Icons.nightlife;
    }
    
      
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
        ),
        Positioned.fill(
          child: CircularProgressIndicator(
            value: percentage[index] / 100,
            strokeWidth: 6,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        Icon(icon, size: 40, color: color),
      ],
    );
  }
}