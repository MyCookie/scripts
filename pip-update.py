import json
import sys
from subprocess import run

print("Checking for out-of-date packages\n")
packages = (run(["pip3 list --outdated --format=json"], shell=True, capture_output=True)).stdout
packages_json = json.loads(packages)
packages_names = [package.get('name') for package in packages_json]

if ('-v' or '--verbose') in sys.argv:
    print("Output of pip3 list --outdated --format=json: \n" + json.dumps(packages_json) + "\n")

if len(packages_names) > 0:
    print("Found " + str(len(packages_names)) + " packages: " + str(packages_names) + "\n")

    for package in packages_json:
        break
        name = package.get('name')
        print("Found out-of-date package " + name)

        pip_instance = run(["pip3 install --upgrade " + name], shell=True, capture_output=True)
        print("\n" + pip_instance.stdout.decode(sys.stdout.encoding) + "\n")
else:
    print("All packages are up-to-date!")

