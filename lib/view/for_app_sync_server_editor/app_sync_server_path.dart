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
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../l10n/localizations.dart';
import '../../model/app_sync_server.dart';
import '../../provider/app_sync_server_form.dart';

class AppSyncServerPathTile extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;

  const AppSyncServerPathTile({
    super.key,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final type = context
        .select<AppSyncServerFormViewModel, AppSyncServerType>((vm) => vm.type);
    final controller =
        context.select<AppSyncServerFormViewModel, TextEditingController>(
            (vm) => vm.pathInputController);
    final canSave =
        context.select<AppSyncServerFormViewModel, bool>((vm) => vm.canSave);
    final l10n = L10n.of(context);
    return Visibility(
      visible: type.includePathField,
      child: ListTile(
        contentPadding: contentPadding,
        title: TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: const Icon(MdiIcons.networkOutline),
            labelText: l10n?.appSync_serverEditor_pathTile_titleText ?? 'Path',
            hintText: l10n?.appSync_serverEditor_pathTile_hintText,
            errorText: (!canSave && controller.text.isEmpty)
                ? l10n?.appSync_serverEditor_pathTile_errorText_emptyPath ??
                    "Path shouldn't be empty!"
                : null,
          ),
          keyboardType: TextInputType.url,
          onChanged: (_) =>
              context.read<AppSyncServerFormViewModel>().refreshCanSaveStatus(),
        ),
      ),
    );
  }
}
