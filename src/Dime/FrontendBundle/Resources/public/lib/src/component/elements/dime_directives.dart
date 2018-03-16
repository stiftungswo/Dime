import '../date/dateRange.dart';
import '../date/dateToTextInput.dart';
import 'dime-button.dart';
import 'download-button.dart';
import 'error_icon.dart';
import 'help-tooltip.dart';
import '../percent-input/percent_input.dart';
import 'dime_form_group.dart';
import 'discount_input.dart';
import 'save_button.dart';
import 'percentage_input.dart';

const dimeDirectives = const [
  DimeButton,
  SaveButton,
  DownloadButton,
  HelpTooltip,
  ErrorIconComponent,
  DateToTextInput,
  DateRange,
  PercentageInputField, //TODO(106) remove
  DiscountInputComponent,
  PercentageInputComponent,
  DimeFormGroup,
  DimeBox,
  ValidationStatusDirective,
];
