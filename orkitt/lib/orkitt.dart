
/// Orkitt UI Framework
/// Copyright (c) 2024 Orkitt. All rights reserved.
/// 
/// Redistribution and use in source and binary forms, with or without
/// modification, are permitted provided that the following conditions are met:
/// 
/// 1. Redistributions of source code must retain the above copyright notice,
///    this list of conditions and the following disclaimer.
/// 
/// 2. Redistributions in binary form must reproduce the above copyright notice,
///    this list of conditions and the following disclaimer in the documentation
///    and/or other materials provided with the distribution.
/// 
/// 3. Neither the name of the copyright holder nor the names of its
///    contributors may be used to endorse or promote products derived from
///    this software without specific prior written permission.
/// 
/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
/// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
/// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
/// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
/// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
/// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
/// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
/// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
/// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
/// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

library;

/// Dart Core Libraries
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

/// Flutter Core Libraries
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart' as theme show ThemeExtension;

/// Flutter SDK
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' as service;
import 'package:flutter/services.dart';

/// =======================
/// 📦 PACKAGE STRUCTURE
/// =======================

/// =======================================================
/// 🌍 CORE FOUNDATION
/// =======================================================
part 'src/core/foundation/constants/orkitt_logo.dart';
part 'src/core/foundation/constants/breakpoints.dart';
part 'src/core/foundation/constants/responsive_enums.dart';
part 'src/core/foundation/abstract/orkitt_theme_engine.dart';
part 'src/core/foundation/abstract/base_theme.dart';
part 'src/core/foundation/abstract/error_abstract.dart';
part 'src/core/foundation/exceptions/app_error.dart';
part 'src/core/foundation/exceptions/exception.dart';
part 'src/core/foundation/exceptions/functional.dart';
part 'src/core/foundation/abstract/progress_indicator.dart';


/// =======================================================
/// ⚙️ STATE MANAGEMENT
/// =======================================================
part 'src/core/state/app_state.dart';
part 'src/core/state/lifecycle.dart';

/// =======================================================
/// 🧭 RESPONSIVE ENGINE
/// =======================================================
/// -- Entry & Builders
part 'src/core/responsive/entry/app_composer.dart';
part 'src/core/responsive/entry/scope_wrapper.dart';
part 'src/core/responsive/entry/core_scale.dart';
part 'src/core/responsive/entry/responsive_builder.dart';
part 'src/core/responsive/entry/base_scaffold.dart';
part 'src/core/responsive/entry/pixel_wrapper.dart';

/// -- Helpers
part 'src/core/responsive/helpers/screen_utils.dart';
part 'src/core/responsive/helpers/design_utils.dart';
part 'src/core/responsive/helpers/smart_extensions.dart';
part 'src/core/responsive/helpers/console_logger.dart';

/// -- Spacing
part 'src/core/responsive/spacing/extended_units.dart';
part 'src/core/responsive/spacing/spacing_extensions.dart';

/// -- Bootstrap-Inspired System
part 'src/core/responsive/bootstrap/breadcrums.dart';
part 'src/core/responsive/bootstrap/display_flex_media.dart';
part 'src/core/responsive/bootstrap/bootstrap_section.dart';
part 'src/core/responsive/bootstrap/flaxable_spacing.dart';

/// =======================================================
/// 🎨 THEME SYSTEM (ORKITT ENGINE)
/// =======================================================
/// -- Color Models
part 'src/core/theme/color/branding.dart';
part 'src/core/theme/color/seed.dart';
part 'src/core/theme/color/swatch.dart';
part 'src/core/theme/color/kolors.dart';
part 'src/core/theme/color/safe_colors.dart';

/// -- Color Palettes
part 'src/core/theme/palettes/twitter_colors.dart';
part 'src/core/theme/palettes/material_color.dart';
part 'src/core/theme/palettes/tailwind_colors.dart';
part 'src/core/theme/palettes/bootstrap_purple.dart';
part 'src/core/theme/palettes/ios_color.dart';
part 'src/core/theme/palettes/default_plates.dart';
part 'src/core/theme/palettes/ui_themes.dart';

/// -- Typography
part 'src/core/theme/typography/base_styles.dart';
part 'src/core/theme/typography/fallback_typo.dart';
part 'src/core/theme/typography/text_weight.dart';
part 'src/core/theme/typography/text_size.dart';

/// -- Builders & Manager
part 'src/core/theme/builders/theme_foundation.dart';
part 'src/core/theme/builders/theme_builder.dart';
part 'src/core/theme/builders/theme_manager.dart';

/// =======================================================
/// 💻 UI FOUNDATION HELPERS
/// =======================================================
part 'src/views/ui_helper.dart';
part 'src/views/extension/widget_ext.dart';
part 'src/views/extension/row_column.dart';
part 'src/views/extension/stacking.dart';
part 'src/views/extension/list_grid.dart';

/// =======================================================
/// 📱 UI COMPONENTS & ELEMENTS
/// =======================================================
/// -- Basic Elements
part 'src/views/basic/appbar_addon.dart';
part 'src/views/basic/label_styles.dart';
part 'src/views/basic/page_indicator.dart';

/// -- Common Components
part 'src/views/common/ui_divider.dart';
part 'src/views/common/ui_label.dart';
part 'src/views/common/ui_dropdown.dart';
part 'src/views/common/ui_drawer.dart';
part 'src/views/common/ui_blur.dart';

/// -- Buttons
part 'src/views/buttons/ui_button.dart';
part 'src/views/buttons/ui_flatbutton.dart';
part 'src/views/buttons/ui_iconbutton.dart';

/// -- Fields & Forms
part 'src/views/fields/ui_textfield.dart';
part 'src/views/fields/ui_otp.dart';
part 'src/views/fields/ui_form.dart';

/// -- Cards & Containers
part 'src/views/cards/ui_container.dart';
part 'src/views/cards/ui_card.dart';
part 'src/views/cards/ui_borderbox.dart';

/// -- Avatars
part 'src/views/avater/ui_avatar_circle.dart';
part 'src/views/avater/ui_avater.dart';

/// -- Tiles & Lists
part 'src/views/tiles/ui_accoridion.dart';
part 'src/views/tiles/ui_listtile.dart';
part 'src/views/tiles/ui_listview.dart';

/// -- Progress & Feedback
part 'src/views/progress/ui_loader.dart';
part 'src/views/progress/ui_miniprogress.dart';
part 'src/views/feedback/ui_feedback.dart';
part 'src/views/feedback/ui_alart.dart';
part 'src/views/feedback/snackbar.dart';
part 'src/views/feedback/toaster.dart';
part 'src/views/feedback/dialog.dart';

/// -- Other Components
part 'src/views/components/ui_theme_switch.dart';
part 'src/views/components/ui_popupmenu.dart';
part 'src/views/components/ui_langselector.dart';

/// -- Error/Fallback Screens
part 'src/views/screens/error_page.dart';
part 'src/core/screens/errors/motivation_msg.dart';

/// =======================================================
/// 🎞️ ANIMATIONS & TRANSITIONS
/// =======================================================
part 'src/core/screens/transition/page_transitions.dart';
part 'src/core/screens/transition/responsive_effects.dart';

/// =======================================================
/// ❌ ERROR & EXCEPTION HANDLING
/// =======================================================
part 'src/core/screens/errors/global_error_ui.dart';
part 'src/core/screens/errors/error_scope.dart';
part 'src/utils/extension/functions/retry_mechanism.dart';

/// =======================================================
/// 🚦 ROUTING & NAVIGATION
/// =======================================================
part 'src/services/navigation/navigator_addons.dart';
part 'src/services/navigation/route_extension.dart';
part 'src/services/navigation/navigator_manager.dart';

/// =======================================================
/// 🌐 LOCALIZATION (i18n / l10n)
/// =======================================================
part 'src/services/localization/language_data.dart';
part 'src/services/localization/rtl_languages.dart';
part 'src/services/localization/language_utils.dart';

/// =======================================================
/// 🧩 UTILITIES & HELPERS
/// =======================================================
/// -- Core Helpers
part 'src/utils/helper/duration_utils.dart';
part 'src/utils/helper/time_format.dart';
part 'src/utils/helper/data_image.dart';
part 'src/utils/helper/network_utils.dart';
part 'src/utils/helper/validator_utils.dart';
part 'src/utils/helper/zero.dart';

/// -- Platform Services
part 'src/services/platform/system_ui_function.dart';
part 'src/services/platform/keyboard_visibility.dart';

/// =======================================================
/// 🧠 EXTENSIONS
/// =======================================================
/// -- Base
part 'src/utils/extension/base/boolean_extension.dart';
part 'src/utils/extension/base/int_extension.dart';
part 'src/utils/extension/base/map_extension.dart';
part 'src/utils/extension/base/string_extension.dart';
part 'src/utils/extension/base/list_extension.dart';
part 'src/utils/extension/base/reg_patterns.dart';
part 'src/utils/extension/base/flutter_widgets.dart';

/// -- Context
part 'src/utils/extension/context/typo_graphy.dart';
part 'src/utils/extension/context/quick_typo.dart';
part 'src/utils/extension/context/responsive.dart';
part 'src/utils/extension/context/brand_extension.dart';
part 'src/utils/extension/context/focus_node.dart';

/// -- Functions
part 'src/utils/extension/functions/async_functions.dart';
part 'src/utils/extension/functions/colors_functions.dart';
part 'src/utils/extension/functions/currency_format.dart';
part 'src/utils/extension/functions/date_time_function.dart';
part 'src/utils/extension/functions/debugger_function.dart';
part 'src/utils/extension/functions/image_to_colors.dart';
part 'src/utils/extension/functions/emojify_string.dart';
part 'src/utils/extension/functions/scroll_controller.dart';
part 'src/utils/extension/functions/string_functions.dart';
part 'src/utils/extension/functions/math_functions.dart';

/// =======================================================
/// 🎨 DECORATIONS & STYLES
/// =======================================================
part 'src/views/decoration/decoration.dart';
part 'src/views/decoration/button_styles.dart';
part 'src/views/decoration/input_decoration.dart';
part 'src/views/decoration/shapes.dart';
part 'src/views/decoration/box_kit.dart';

/// =======================================================
/// 🧪 MOCK / DEMO DATA
/// =======================================================
part 'src/data/faker/mock_data.dart';
part 'src/data/faker/data_generator.dart';
part 'src/models/fake_model.dart';

/// =======================================================
/// 📊 MODELS
/// =======================================================
part 'src/models/frame_model.dart';
part 'src/models/media_info.dart';
part 'src/models/orentaion_lock.dart';

