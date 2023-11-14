import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermodule/constants/AppColors.dart';

///DialogUtil
class DialogUtil {
  ///显示简单 多选项弹框，选项按钮竖向居中排列
  static Future<void> showSimpleDialog({
    required BuildContext context,
    String? title, //标题
    List<String> options = const [], //选项
    Function(int)? onOptionSelected, //选中回调
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: title != null ? _buildTitleWidget(context, title) : null,
          children:
              _buildSimpleDialogOptions(context, options, onOptionSelected),
        );
      },
    );
  }

  static _buildSimpleDialogOptions(BuildContext context, List<String> options,
      Function(int)? onOptionSelected) {



    return List.generate(options.length, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.color_F5F6FA, // 背景颜色
          borderRadius: BorderRadius.circular(60.0), // 圆角
        ),
        height: 45,
        child: InkWell(
          onTap: () {
            onOptionSelected?.call(index);
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              options[index],
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.color_FF7C8190, // 文字颜色
              ),
              overflow: TextOverflow.ellipsis, // 自动省略号
            ),
          ),
        ),
      );
      });
  }

  static Future<void> showAlertDialog({
    required BuildContext context,
    String? title,
    String? content,
    String? confirmText = '确认',
    String? cancelText = '取消',
    Function? onConfirm,
    Function? onCancel,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? _buildTitleWidget(context, title) : null,
          content: content != null ? _buildContentText(context, content) : null,
          actions: _buildAlertDialogActions(
            context,
            confirmText,
            cancelText,
            onConfirm,
            onCancel,
          ),
        );
      },
    );
  }

  static List<Widget> _buildAlertDialogActions(
    BuildContext context,
    String? confirmText,
    String? cancelText,
    Function? onConfirm,
    Function? onCancel,
  ) {
    List<Widget> actions = [];

    if (cancelText != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            onCancel != null ? onCancel() : null;
            Navigator.of(context).pop();
          },
          child: Text(cancelText),
        ),
      );
    }

    if (confirmText != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            onConfirm != null ? onConfirm() : null;
            Navigator.of(context).pop();
          },
          child: Text(confirmText),
        ),
      );
    }

    return _centerAlignActionsIfNeeded(actions);
  }

  static List<Widget> _centerAlignActionsIfNeeded(List<Widget> actions) {
    if (actions.length == 1) {
      return [
        Center(
          child: actions[0],
        ),
      ];
    } else if (actions.length == 2) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            actions[0],
            const SizedBox(width: 20),
            actions[1],
          ],
        ),
      ];
    } else {
      return actions;
    }
  }

  static Future<void> showCupertinoAlertDialog({
    required BuildContext context,
    String? title,
    String? content,
    String? confirmText = '确认',
    String? cancelText = '取消',
    Function? onConfirm,
    Function? onCancel,
  }) async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title != null ? _buildTitleWidget(context, title) : null,
          content: content != null ? _buildContentText(context, content) : null,
          actions: _buildCupertinoDialogActions(
            context,
            confirmText,
            cancelText,
            onConfirm,
            onCancel,
          ),
        );
      },
    );
  }

  static List<Widget> _buildCupertinoDialogActions(
      BuildContext context,
      String? confirmText,
      String? cancelText,
      Function? onConfirm,
      Function? onCancel,
      ) {
    List<Widget> actions = [];

    if (cancelText != null) {
      actions.add(
        CupertinoButton(
          onPressed: () {
            onCancel != null ? onCancel() : null;
            Navigator.of(context).pop();
          },
          child: Text(cancelText),
        ),
      );
    }

    if (confirmText != null) {
      actions.add(
        CupertinoButton(
          onPressed: () {
            onConfirm != null ? onConfirm() : null;
            Navigator.of(context).pop();
          },
          child: Text(confirmText),
        ),
      );
    }

    return actions;
  }


  static Future<void> showStatefulWidgetDialog({
    required BuildContext context,
    required StatefulBuilder statefulBuilder
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) => statefulBuilder,
    );
  }

  static Widget _buildTitleWidget(BuildContext context, String title) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width -
            35.0, // 48.0 is the default horizontal padding
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, color: AppColors.color_333333, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  static Widget _buildContentText(BuildContext context, String content) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width -
              48.0, // 48.0 is the default horizontal padding
        ),
        child: Center(
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: AppColors.color_333333),
          ),
        ),
      ),
    );
  }
}
