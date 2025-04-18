// Copyright 2025 Fries_I23
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/localizations.dart';
import '../../provider/app_sync_server_form.dart';
import '../common/_dialog.dart';

class AppSyncServerSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppSyncServerSaveButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) =>
      Selector<AppSyncServerFormViewModel, bool>(
        selector: (context, vm) => vm.canSave,
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, value, child) => TextButton(
          onPressed: value ? onPressed : null,
          child: Text(L10n.of(context)?.confirmDialog_confirm_text(
                  NormalizeConfirmDialogType.save.name) ??
              "save"),
        ),
      );
}
