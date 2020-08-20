#!/home/linuxbrew/.linuxbrew/bin/python3

import json
import sys
from subprocess import run

options = sys.argv[1:] # sys.argv[0] is always the full path of the script on *nix
all_ok = None

print("Use -v or --verbose to get a detailed list of avialable packagees")
print("\nChecking for out-of-date packages...\n")

packages = (run(["pip3 list --outdated --format=json"], shell=True, capture_output=True)).stdout
packages_json = json.loads(packages)
packages_names = [package.get('name') for package in packages_json]

if ('-v' or '--verbose') in options:
    print("Output of pip3 list --outdated --format=json: \n" + json.dumps(packages_json) + "\n")

if len(packages_names) > 0:
    print("Found " + str(len(packages_names)) + " packages: " + str(packages_names) + "\n")
    all_ok = input("Continue? (y/N) ")

    if all_ok.lower() == 'y':
        for package in packages_json:
            name = package.get('name')
            print("Found out-of-date package " + name)

            pip_instance = run(["pip3 install --upgrade " + name], shell=True, capture_output=True)
            print("\n" + pip_instance.stdout.decode(sys.stdout.encoding) + "\n")
else:
    all_ok = 'y'

if all_ok.lower() == 'y':
    print("Updated " + str(len(packages_names)) + " packages")
else:
    print(str(len(packages_names)) + " packages not updated: " + str(packages_names))

