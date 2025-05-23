// Copyright 2024 Fries_I23
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../extension/async_extensions.dart';
import 'db_helper_provider.dart';

class DBHelperBuilder extends SingleChildStatelessWidget {
  final TransitionBuilder builder;
  final TransitionBuilder? loadingBuilder;
  final ErrorWidgetBuilder? errorBuilder;

  const DBHelperBuilder({
    super.key,
    super.child,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  Future<bool> _loadingHelper(BuildContext context) {
    final helper = context.read<DBHelperViewModel>();
    if (helper.mounted && !helper.inited) return helper.init();
    return Future.value(helper.inited);
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      ChangeNotifierProvider(
        create: (context) => DBHelperViewModel()..init(),
        lazy: false,
        child: child,
        builder: (context, child) => FutureBuilder(
          future: _loadingHelper(context),
          builder: (context, snapshot) {
            if (snapshot.hasError ||
                (snapshot.hasData && snapshot.data == false)) {
              final error =
                  snapshot.error ?? FlutterError("db helper build failed");
              final stackTrace = snapshot.stackTrace ?? StackTrace.current;
              if (errorBuilder != null) {
                return errorBuilder!(FlutterErrorDetails(
                    exception: error,
                    stack: stackTrace,
                    library: "db_builder"));
              } else {
                Error.throwWithStackTrace(error, stackTrace);
              }
            } else if (snapshot.isDone) {
              return builder(context, child);
            } else {
              return loadingBuilder?.call(context, child) ??
                  const SizedBox.shrink();
            }
          },
        ),
      );
}
