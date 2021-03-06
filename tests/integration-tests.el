(defun buffer-contains-substring (string)
  (save-excursion
    (save-match-data
      (goto-char (point-min))
      (search-forward string nil t))))

(ert-deftest skeleton-integration-test ()
  (org-present-remote--remote-off)

  (when (get-buffer "test.org")
    (kill-buffer "test.org"))

  (with-current-buffer (generate-new-buffer "test.org")
    (org-mode)
    (insert "* heading 1\n* heading 2")
    (goto-char (point-min))
    (org-present)
    (org-present-remote--remote-on "127.0.0.1"))

  (with-current-buffer (url-retrieve-synchronously "http://127.0.0.1:8009/" :silent nil)
    (should (buffer-contains-substring "<h1>test.org</h1>"))
    (should (buffer-contains-substring "<h2>heading 1</h2>")))

  (with-current-buffer (url-retrieve-synchronously "http://127.0.0.1:8009/next" :silent nil)
    (should (buffer-contains-substring "<h1>test.org</h1>"))
    (should (buffer-contains-substring "<h2>heading 2</h2>")))

  (with-current-buffer (url-retrieve-synchronously "http://127.0.0.1:8009/prev" :silent nil)
    (should (buffer-contains-substring "<h1>test.org</h1>"))
    (should (buffer-contains-substring "<h2>heading 1</h2>"))))

