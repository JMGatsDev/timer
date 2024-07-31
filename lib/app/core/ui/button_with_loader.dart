import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<s>, s>
    extends StatelessWidget {
  const ButtonWithLoader(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.selector,
      required this.bloc});
  final VoidCallback onPressed;
  final String label;
  final BlocWidgetSelector<s, bool> selector;
  final B bloc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: BlocSelector<B, s, bool>(
          bloc: bloc,
          selector: selector,
          builder: (context, showLoading) {
            if (!showLoading) {
              return Text(label);
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                Text(label),
                const Align(
                  alignment: Alignment.centerRight,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            );
          },
        ));
  }
}
