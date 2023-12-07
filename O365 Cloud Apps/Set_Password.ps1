#This will create a password file to use in a script so you can pass it through.
(get-credential).password | ConvertFrom-SecureString | set-content "C:\scripts\passwordtest.txt"
