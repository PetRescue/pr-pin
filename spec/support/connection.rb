PIN_SECRET_KEY = SecureRandom.hex(11)

PR::Pin.connect(secret_key: PIN_SECRET_KEY)
