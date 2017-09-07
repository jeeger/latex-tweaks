;;; latex-tweaks.el --- A collection of tweaks for auctex.  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  

;; Author:  Jan Seeger <jan.seeger@thenybble.de>
;; Keywords:  tex

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

;; Enable all tweaks with (LaTeX-tweaks-insinuate).

;;; Code:

(defcustom LaTeX-inhibited-auto-fill-environments
  '("tabular" "tikzpicture") "For which LaTeX environments not to run auto-fill.")

(defun LaTeX-limited-auto-fill ()
  (let ((environment (LaTeX-current-environment)))
    (when (not (member environment LaTeX-inhibited-auto-fill-environments))
      (do-auto-fill))))

(defun LaTeX-dont-break-on-nbsp ()
  (and (eq major-mode 'latex-mode)
       (eq (char-before (- (point) 1)) ?\\)))

(defun LaTeX-collapse-table ()
  (interactive)
  (save-excursion
    (LaTeX-mark-environment)
    (while (re-search-forward "[[:space:]]+\\(&\\|\\\\\\\\\\)" (region-end) t)
      (replace-match " \\1"))))

(defun LaTeX-align-environment (arg)
  (interactive "P")
  (if arg
      (LaTeX-collapse-table)
    (save-excursion
      (LaTeX-mark-environment)
      (align (region-beginning) (region-end)))))

(defun LaTeX-underscore-maybe (arg)
  (interactive "p")
  (if (eq last-command 'LaTeX-underscore-maybe)
      (progn
        (delete-backward-char 2)
        (self-insert-command 1))
    (if (or (or (> 1 arg) (texmathp)))
        (self-insert-command 1)
      (insert "\\_"))))

(defun LaTeX-tweaks-insinuate ()
  (local-set-key (kbd "_" #'LaTeX-underscore-maybe))
  (local-set-key (kbd "C-c f") #'LaTeX-align-environment)
  (setq auto-fill-function #'LaTeX-limited-auto-fill)
  (add-to-list 'fill-nobreak-predicate #'LaTeX-dont-break-on-nbsp))

(provide 'latex-tweaks)
;;; latex-tweaks.el ends here
