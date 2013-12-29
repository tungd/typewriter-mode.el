;;; typewriter-mode.el --- typewriter sounds fx when typing

;; Copyright (C) 2013  Tung Dao

;; Author: Tung Dao <me@tungdao.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Minor mode for playing typewriter sounds when typing.

;;; Code:

(defcustom twm/sound-file
  (format "%stypewriter-key-modern.wav"
          (file-name-directory load-file-name))
  "Path to sound file."
  :group 'typewriter-mode)

(defcustom twm/play-command
  (case system-type
    ('darwin "play %s")
    ('gnu/linux "aplay %s"))
  "Command to play sound file."
  :group 'typewriter-mode)

(defun twm/play-typewriter-sound ()
  (start-process-shell-command
   "*play-typewriter-sound*" nil
   (format twm/play-command twm/sound-file)))

;;;###autoload
(defun turn-on-typewriter-mode ()
  (add-hook 'post-self-insert-hook #'twm/play-typewriter-sound))

;;;###autoload
(defun turn-off-typewriter-mode ()
  (remove-hook 'post-self-insert-hook #'twm/play-typewriter-sound))

;;;###autoload
(define-minor-mode typewriter-mode
  "Toggle typewriter-mode"
  nil
  "" ;; lighter
  ;; keymap
  nil
  :global t
  (if typewriter-mode
      (turn-on-typewriter-mode)
    (turn-off-typewriter-mode)))

(provide 'typewriter-mode)
;;; typewriter-mode.el ends here