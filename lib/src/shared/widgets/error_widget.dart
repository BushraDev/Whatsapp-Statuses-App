import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:meta/meta.dart';

import 'package:statusesapp/src/shared/layout/responsive.dart';
import 'package:statusesapp/src/shared/layout/platform_widget.dart';
import 'package:statusesapp/src/shared/messages/messages.dart';

class ErrorWidget extends ConsumerWidget {
  final String message;
  final provider;

  const ErrorWidget({Key key, @required this.message, @required this.provider})
      : assert(message != null, 'A non-null String must be provided'),
        super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return TargetPlatformWidget(
      materialWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            SizedBox(
              height: 20.hdp,
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              padding:
                  EdgeInsets.symmetric(horizontal: 20.hdp, vertical: 10.hdp),
              fillColor: Theme.of(context).accentColor,
              textStyle: Theme.of(context).textTheme.subtitle1,
              onPressed: () {
                context.refresh(provider);
              },
              child: Text(AppMessages.reTry),
            ),
          ],
        ),
      ),
    );
  }
}
