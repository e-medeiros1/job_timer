import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;
  //Criando o onPressed
  final VoidCallback onPressed;
  final String label;

  const ButtonWithLoader({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.selector,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
        bloc: bloc,
        selector: selector,
        builder: (context, showLoading) {
          return ElevatedButton(
              onPressed: showLoading ? null : onPressed,
              style: !showLoading
                  ? ElevatedButton.styleFrom()
                  : ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      onSurface: Colors.blue,
                    ),
              child: !showLoading
                  ? Text(label)
                  : Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                        backgroundColor: Colors.white,
                      ),
                    ));
        });
  }
}
