import 'package:covid/resources/style/text_styles.dart';
import 'package:flutter/material.dart';

class CardVideo extends StatelessWidget {
  const CardVideo({
    Key key,
    @required this.backgroundUrl,
    this.onPressed,
    this.label,
    this.labelAlignment = Alignment.bottomCenter,
  }) : super(key: key);

  final String backgroundUrl;
  final String label;
  final Alignment labelAlignment;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final decoration = backgroundUrl == null
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Theme.of(context).primaryColor,
          )
        : BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
              image: NetworkImage(backgroundUrl),
              fit: BoxFit.cover,
            ),
          );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 144.0,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(18.0),
        alignment: Alignment.center,
        decoration: decoration,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ButtonTheme(
              minWidth: 0.0,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              buttonColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: RaisedButton(
                elevation: 4.0,
                onPressed: onPressed,
                disabledColor: Colors.transparent,
                child: Icon(
                  Icons.play_circle_filled,
                  size: 48.0,
                  color: onPressed != null
                      ? Theme.of(context).textTheme.button.color
                      : Theme.of(context).disabledColor,
                ),
              ),
            ),
            if (label != null)
              Align(
                alignment: labelAlignment,
                child: Text(
                  label,
                  style: TextStyles.subtitle(color: Colors.white)
                      .copyWith(shadows: [
                    const Shadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 3.0,
                    ),
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
