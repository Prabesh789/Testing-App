import 'package:flutter/material.dart';

class TodoTask extends StatelessWidget {
  final String text;
  final bool isDone;

  const TodoTask({Key key, this.text, @required this.isDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 12),
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: isDone
                  ? null
                  : Border.all(
                      color: Color(0xFF86829D),
                      width: 1.5,
                    ),
              color: isDone ? Color(0xFF7349FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image(
              image: AssetImage(
                'assets/images/check_icon.png',
              ),
            ),
          ),
          Text(
            text ?? "Unnamed Todo",
            style: TextStyle(
              color: isDone ? Color(0xFF211551) : Color(0xFF86829D),
              fontSize: 14,
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
