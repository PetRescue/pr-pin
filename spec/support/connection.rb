PIN_SECRET_KEY = SecureRandom.hex(11)

PR::Pin.register_connection(secret_key: PIN_SECRET_KEY)
