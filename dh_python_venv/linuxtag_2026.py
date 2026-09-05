#!/usr/bin/env python3

from cryptography.fernet import Fernet

def main():
    key = Fernet.generate_key()
    print("Hello Linuxtag 2026 with venv")
    print(f"Your key is {key.hex()[:8]}...")

if __name__ == "__main__":
    main()
