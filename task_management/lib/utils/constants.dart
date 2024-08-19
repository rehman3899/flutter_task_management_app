import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:task_management/main.dart';
import 'package:task_management/utils/app_string.dart';

String lottieURL = 'assets/lottie.json';

/// Empty Title or subTitle Text Warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppString.oopsMsg,
      subMsg: 'You Must fill All Field!',
      corner: 20.0,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

/// nothing enter when user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppString.oopsMsg,
      subMsg: 'You must edit the task and then try to update it!',
      corner: 20.0,
      duration: 5000,
      padding: const EdgeInsets.all(20));
}

// No task Warning dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppString.oopsMsg,
    message:
        'There is no Task For Delete! \n Add some Task and then try to Delete it!',
    buttonText: 'Okay',
    onTapDismiss: () {
      Navigator.of(context).pop();
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

// Dialog for deleting all task from the database
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppString.areYouSure,
    message: 'Are you sure you want to delete all tasks? You will not be able to undo this action!',
    confirmButtonText: 'Yes',
    cancelButtonText: 'No',
    onTapConfirm: (){
      // Delete all task from the database
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: (){
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false 
  );
}
