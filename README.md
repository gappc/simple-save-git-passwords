# simple-save-git-passwords

This repository contains the files mentioned in the blog post [A simple and secure way to store passwords in GIT](https://gappc.net/2017/08/simple-and-secure-way-to-store-passwords-in-git/).

## What is this?
Did you ever think about storing passwords in a Git repository? In certain circumstances it can be very convenient, for example if the passwords are part of the project itself. But storing passwords in a plain text file that gets committed is a bad idea. Everyone with access to the repository will be able to read them (for example, if you upload your project to a public GitHub project). Removing passwords from a Git repository is [possible](https://help.github.com/articles/removing-sensitive-data-from-a-repository/), but a rather ugly solution and often the damage already happened.

## Basic idea

A better approach is to encrypt a plain text password file before it is committed and exclude the plain text file from source control at all. The basic idea is to have two files in the Git project:

- the first file contains the passwords in plain text. Lets call this file ```passwords.txt```. Since ```passwords.txt``` contains sensitive data, it must be excluded from Git. This is accomplished by adding the file to ```.gitignore```.
- the second file is the encrypted version of ```passwords.txt```. Lets call it ```encrypted-passwords.cast5```. Since this file is the encrypted version of ```passwords.txt```, it can be safely committed to Git (given you use a strong encryption password).
Encrypt ```passwords.txt``` on changes and commit the resulting ```encrypted-passwords.cast5``` file. Decrypt ```encrypted-passwords.cast5``` to restore your passwords into the plain text file ```passwords.txt```. Use the tool of your choice to make the encryption / decryption process more convenient.

## Requirements
- [make](https://www.gnu.org/software/make/)
- [OpenSSL](https://www.openssl.org/)

If you run Linux you may already have everything in its place, make and OpenSSL are part of most Linux systems. If they are not installed, use your package manager to install them. For example, if you use Ubuntu, install them with the following command:

```sudo apt install make openssl```

macOS users find make in the Apple developer tools and OpenSSL in Homebrew.

If you are a Windows user I have to disappoint you: make and OpenSSL are not installed on Windows by default, but can be found for example in [mingw](http://www.mingw.org/). If you don't like mingw, it should also not be to hard to find suitable replacements in the Windows world.

## Usage

The usage is simple. Assuming make and OpenSSL are installed and the Makefile is located in the current directory, you can use:

- ```make encrypt_conf``` to encrypt a plain text ```passwords.txt``` file to an encrypted```encrypted-passwords.cast5``` file, that can be safely committed to the Git repository. During the encryption process, you will be asked for an encryption password. Chose a strong password (can be generated e.g. here). This password will be used during the decryption process, so don’t forget it.
- ```make decrypt_conf``` to decrypt the encrypted password file ```encrypted-passwords.cast5```. As a result, the plain text file ```passwords.txt``` will be written. During decryption you will be asked for the password that you used for encryption.
Now you can work with your Git project without the fear of storing sensitive data and still your passwords are part of the project.

## Example
Use the example ```encrypted-passwords.cast5``` file contained in this repository and try to decrypt it, by executing ```make decrypt_conf```. The password is "```1234```". On successful decryption, a file called ```passwords.txt``` should be created. Next, change the content of ```passwords.txt``` and execute ```make encrypt_conf```. On success, this command overwrites the existing ```encrypted-passwords.cast5``` file, which in turn could be commited again. 