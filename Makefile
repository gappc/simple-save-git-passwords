PASSWORD_FILE=passwords.txt
ENCRYPTED_FILE=encrypted-passwords.cast5

# 'Private' task for echoing instructions
_pwd_prompt:
	@echo "Usage: make [encrypt_conf|decrypt_conf]"

# Encrypt password file
encrypt_conf:
    openssl cast5-cbc -e -in ${PASSWORD_FILE} -out ${ENCRYPTED_FILE}

# Decrypt password file
decrypt_conf:
    openssl cast5-cbc -d -in ${ENCRYPTED_FILE} -out ${PASSWORD_FILE}
    chmod 600 ${PASSWORD_FILE}
