(in-package :cl-report)


(defparameter *material-icons*
  '("home" "3d_rotation" "accessibility" "account_balance" "account_balance_wallet" "account_box" "account_circle"
    "add_alert" "add_box" "add_circle" "add_circle_outline" "add_shopping_cart" "alarm" "alarm_add"
    "alarm_off" "alarm_on" "all_out" "android" "announcement" "arrow_right_alt" "aspect_ratio" "assessment"
    "assignment" "assignment_ind" "assignment_late" "assignment_return" "assignment_returned" "assignment_turned_in"
    "autorenew" "backup" "book" "bookmark" "bookmark_border" "bug_report" "build" "cached" "camera_enhance"
    "card_giftcard" "card_membership" "card_travel" "change_history" "check_circle" "check_circle_outline"
    "chrome_reader_mode" "class" "code" "compare_arrows" "contact_support" "credit_card" "dashboard" "date_range"
    "delete" "delete_forever" "description" "dns" "done" "done_all" "done_outline" "donut_large" "donut_small"
    "drag_indicator" "eject" "euro_symbol" "event" "event_seat" "exit_to_app" "explore" "extension" "face" "favorite"
    "favorite_border" "feedback" "find_in_page" "find_replace" "fingerprint" "flight_land" "flight_takeoff" "flip_to_back"
    "flip_to_front" "g_translate" "gavel" "get_app" "gif" "grade" "group_work" "help" "help_outline" "highlight_off"
    "history" "home" "horizontal_split" "hourglass_empty" "hourglass_full" "http" "https" "important_devices"
    "info" "input" "invert_colors" "label" "label_important" "label_outline" "language" "launch" "line_style" "line_weight"
    "list" "lock" "lock_open" "loyalty" "markunread_mailbox" "maximize" "minimize" "motorcycle" "note_add" "offline_pin"
    "opacity" "open_in_browser" "open_in_new" "open_with" "pageview" "pan_tool" "payment" "perm_camera_mic" "perm_contact_calendar"
    "perm_data_setting" "perm_device_information" "perm_identity" "perm_media" "perm_phone_msg" "perm_scan_wifi" "pets"
    "picture_in_picture" "picture_in_picture_alt" "play_for_work" "polymer" "power_settings_new" "pregnant_woman" "print"
    "query_builder" "question_answer" "receipt" "record_voice_over" "redeem" "remove" "remove_circle" "remove_circle_outline"
    "remove_from_queue" "remove_red_eye" "remove_shopping_cart" "reorder" "report_problem" "restore" "restore_page"
    "room" "rounded_corner" "rowing" "schedule" "search" "settings" "settings_applications" "settings_backup_restore"
    "settings_bluetooth" "settings_brightness" "settings_cell" "settings_ethernet" "settings_input_antenna"
    "settings_input_component" "settings_input_composite" "settings_input_hdmi" "settings_input_svideo"
    "settings_overscan" "settings_phone" "settings_power" "settings_remote" "settings_voice" "shop" "shop_two" "shopping_basket"
    "shopping_cart" "speaker_notes" "speaker_notes_off" "spellcheck" "stars" "store" "store_mall_directory" "straighten"
    "supervisor_account" "swap_calls" "swap_horiz" "swap_vertical_circle" "swap_vertical_circle" "system_update"
    "tab" "tab_unselected" "theaters" "thumb_down" "thumb_up" "thumbs_up_down" "timeline" "toc" "today" "toll" "touch_app"
    "track_changes" "translate" "trending_down" "trending_flat" "trending_up" "turned_in" "turned_in_not" "update"
    "verified_user" "view_agenda" "view_array" "view_carousel" "view_column" "view_day" "view_headline" "view_list" "view_module"
    "view_quilt" "view_stream" "view_week" "visibility" "visibility_off" "watch_later" "work" "youtube_searched_for"
    "zoom_in" "zoom_out"))

(defun material-icons-list ()
  "Genera una lista de íconos de Material Icons."
  (spinneret:with-html-string
  (:ul
   (loop for icon in *material-icons*
         :collect
         (:li (:i :class (str:concat "material-icons") icon) icon)))))








