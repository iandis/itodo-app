import 'package:flutter/cupertino.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    Key? key,
    this.size = 10,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(radius: size),
    );
  }
}
