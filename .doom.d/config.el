;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Each path is relative to the path of the maildir you passed to mu
;(set-email-account! "protonmail"
;  '((mu4e-sent-folder       . "/ProtonMail/Sent")
;    (mu4e-drafts-folder     . "/ProtonMail/Drafts")
;    (mu4e-trash-folder      . "/ProtonMail/Trash")
;    (mu4e-refile-folder     . "/ProtonMail/All Mail")
;    (smtpmail-smtp-user     . "kirkmatt@proton.me")
;    (mu4e-compose-signature . "Kind Regards,\nKirkm"))
;  t)
;(setq mu4e-smtp-server "127.0.0.1")
;(setq mu4e-smtp-port 1025)
;(setq mu4e-smtp-user "kirkmatt@proton.me")
;(setq mu4e-smtp-auth 'plain)  ;; Or 'login if that works
;(setq mu4e-smtp-tls nil)
;(add-to-list 'load-path "/home/kirkm/.config/emacs/.local/straight/build-29.4/evil-collection/modes")
;(add-to-list 'load-path "/home/kirkm/.config/emacs/.local/straight/build-29.4/evil-collection/modes/mu4e")

;(setq smtpmail-smtp-server "127.0.0.1")
;(setq smtpmail-smtp-service 1025)
;(setq user-full-name "Kirk Matt")
;(setq mail-user-agent 'message-user-agent)
;(setq user-mail-address "kirkmatt@proton.me")
;(setq sendmail-program "/home/kirkm/.nix-profile/bin/msmtp"
;      send-mail-function 'message-send-mail-with-sendmail)
;(setq smtpmail-smtp-user "kirkmatt@proton.me")
;(setq user-mail-address "kirkmatt@proton.me")
;(setq mu4e-smtp-server "127.0.0.1"
;      mu4e-smtp-user "kirkmatt@proton.me"
;      mu4e-smtp-port 1025
;      mu4e-smtp-auth 'plain)
;(setq smtpmail-smtp-user "kirkmatt@proton.me")
;(setq smtpmail-default-smtp-server "127.0.0.1")
;(setq smtpmail-smtp-service 1025)
;(setq sendmail-program "/home/kirkm/.nix-profile/bin/msmtp")
;(setq send-mail-function 'message-send-mail-with-sendmail)
;(setq smtpmail-auth-credentials (expand-file-name "~/.msmtprc"))
;(setq smtpmail-smtp-tls nil) ;; Disable TLS if ProtonMail Bridge does not use it
(use-package mu4e
  :defer 20 ; Wait until 20 seconds after startup
  :config

  (setq mu4e-change-filenames-when-moving t ; avoid sync conflicts
      mu4e-update-interval (* 10 60) ; check mail 10 minutes
      mu4e-compose-format-flowed t ; re-flow mail so it's not hard wrapped
      mu4e-get-mail-command "mbsync -a"
      mu4e-maildir "~/mail/ProtonMail")

  (setq mu4e-drafts-folder "/ProtonMail/Drafts"
      mu4e-sent-folder   "/ProtonMail/Sent"
      mu4e-refile-folder "/ProtonMail/All Mail"
      mu4e-trash-folder  "/ProtonMail/Trash")

  (setq mu4e-maildir-shortcuts
      '(("/ProtonMail/inbox"     . ?i)
        ("/ProtonMail/Sent"      . ?s)
        ("/ProtonMail/Trash"     . ?t)
        ("/ProtonMail/Drafts"    . ?d)
        ("/ProtonMail/All Mail"  . ?a)))

  (setq message-send-mail-function 'smtpmail-send-it
      auth-sources '("~/.authinfo") ;need to use gpg version but only local smtp stored for now
      smtpmail-smtp-server "127.0.0.1"
      smtpmail-smtp-service 1025
      smtpmail-stream-type  'plain))

;(require 'org-caldav)
;
;;; URL of the caldav server
;(setq org-caldav-url "https://scientia-eu-v4-api-d3-02.azurewebsites.net//api/ical/b5098763-4476-40a6-8d60-5a08e9c52964/33ff0a46-42c9-fa35-e710-20a89e30a8cd/timetable.ics")
;
;;; calendar ID on server
;(setq org-caldav-calendar-id "MathhewKirk")
;
;;; Org filename where new entries from calendar stored
;(setq org-caldav-inbox "/home/kirkm/Calendar/Uni/inbox.org")
;
;;; Additional Org files to check for calendar events
;(setq org-caldav-files nil)
;
;;; Usually a good idea to set the timezone manually
;(setq org-icalendar-timezone "Europe/Berlin")
;
;(use-package! calfw
;  :defer t
;  :init
;  (map! :leader
;        :prefix "o"
;        :desc "Calendar" :e "c" #'cfw:open-org-calendar)
;
;  :config
;  (map! :map cfw:calendar-mode-map
;        :m "C-j" #'cfw:navi-next-month-command
;        :m "C-k" #'cfw:navi-previous-month-command
;        :m "C-." #'cfw:navi-goto-today-command
;        :m "0"   #'cfw:navi-goto-week-begin-command
;        :m "gd"  #'cfw:org-goto-date
;        :m "zd"  #'cfw:change-view-day
;        :m "zw"  #'cfw:change-view-week
;        :m "zm"  #'cfw:change-view-month
;        :m "zt"  #'cfw:change-view-two-weeks
;        :m "T"   #'cfw:change-view-two-weeks)) ;; not active due to evil-snipe and evil-find-char
;
;(use-package! org-caldav
;  :after calfw
;  :init
;  (map! :leader
;        :prefix "n"
;        :desc "Sync with server" :e "C-s" #'org-caldav-sync)
;
;  :config
;  (setq
;   org-caldav-url ("https://scientia-eu-v4-api-d3-02.azurewebsites.net//api/ical/b5098763-4476-40a6-8d60-5a08e9c52964/33ff0a46-42c9-fa35-e710-20a89e30a8cd/timetable.ics")
;   org-caldav-show-sync-results nil
;   org-caldav-save-directory (expand-file-name ".caldav/" org-directory)
;   org-caldav-backup-file (expand-file-name "backup.org" org-caldav-save-directory)
;   org-caldav-location-newline-replacement ","
;   org-caldav-exclude-tags '("nocal")))


(defun calendar-helper () ;; doesn't have to be interactive
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Purple")
    (cfw:ical-create-source "Uni" "https://scientia-eu-v4-api-d3-02.azurewebsites.net//api/ical/b5098763-4476-40a6-8d60-5a08e9c52964/33ff0a46-42c9-fa35-e710-20a89e30a8cd/timetable.ics" "Grey")
    (cfw:ical-create-source "Life" "https://calendar.proton.me/api/calendar/v1/url/1RZQ6qxSo4AGgUOR_cCVlj9d_KXgckkAdOEN0wszIXMvSXALutYgoIiNWltRW2q5_EUdfmwf4zwM2wYdDIPdCA==/calendar.ics?CacheKey=CuxtvSb__5z15LJQckBW7w%3D%3D&PassphraseKey=cHyl07vC-qgAdoCiCQZZZvcItem-zCk6fYfdCnn1_E4%3D" "Black"))))
    
(defun calendar-init ()
  ;; switch to existing calendar buffer if applicable
  (if-let (win (cl-find-if (lambda (b) (string-match-p "^\\*cfw:" (buffer-name b)))
                           (doom-visible-windows)
                           :key #'window-buffer))
      (select-window win)
    (calendar-helper)))
(defun =my-calendar ()
  "Activate (or switch to) *my* `calendar' in its workspace."
  (interactive)
  (if (featurep! :ui workspaces) ;; create workspace (if enabled)
      (progn
        (+workspace-switch "Calendar" t)
        (doom/switch-to-scratch-buffer)
        (calendar-init)
        (+workspace/display))
    (setq +calendar--wconf (current-window-configuration))
    (delete-other-windows)
    (switch-to-buffer (doom-fallback-buffer))
    (calendar-init)))
