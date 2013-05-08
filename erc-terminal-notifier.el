;;; erc-terminal-notifier.el --- ERC Nick highlight with terminal-notifier

;; Copyright (c) 2013 Julien Blanchard <julien@sideburns.eu>

;; Author: Julien Blanchard <julien@sideburns.eu>
;; URL: http://github.com/julienXX/
;; Keywords: erc terminal-notifier nick
;; Created: 08 May 2013
;; Version: 0.1

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; ERC Nick highlight with the terminal-notifier gem.
;;

;;; Install

;; $ cd ~/.emacs.d/vendor
;; $ git clone git://github.com/julienXX/erc-terminal-notifier.el.git
;;
;; In your emacs config:
;;
;; (add-to-list 'load-path "~/.emacs.d/vendor/erc-terminal-notifier.el")
;; (require 'erc-terminal-notifier)

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(defvar terminal-notifier-command (executable-find "terminal-notifier") "The path to terminal-notifier.")

(defun notification-center (title message)
  "Show a message with `terminal-notifier-command`."
  (start-process "terminal-notifier"
                 "*terminal-notifier*"
                 terminal-notifier-command
                 "-title" title
                 "-message" message
                 "-activate" "org.gnu.Emacs"))

(defun erc-terminal-notifier-hook (match-type nick message)
  "Show a notification, when user's nick is mentioned."
  (when (eq match-type 'current-nick)
    (unless (posix-string-match "^\\** *Users on #" message)
      (notification-center
       (concat "ERC " (buffer-name (current-buffer)))
       message))))

(add-hook 'erc-text-matched-hook 'erc-terminal-notifier-hook)

(provide 'erc-terminal-notifier)
;;; erc-terminal-notifier ends here