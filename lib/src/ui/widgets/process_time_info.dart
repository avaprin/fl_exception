import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProcessTime extends StatelessWidget {
  double averageTime;
  int currentTime;
  String imageUrl;
  int r;
  int g;
  int b;

  ProcessTime(
      {this.averageTime, this.currentTime, this.imageUrl, this.r, this.g, this.b});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: 350,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 300,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 27, top: 13),
                  width: averageTime*250,
                  height: 10,
                  decoration: BoxDecoration(color: Color.fromRGBO(r, g, b, 1),
                  borderRadius: BorderRadius.circular(7)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.network(
                    imageUrl,
                    width: 34,
                    height: 34,
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Text(currentTime.toString()+" мин"),
          ),
        ],
      ),
    );
  }
}
