(require 'package)
(package-initialize)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/"))
(package-install 'elnode 'org-present)
