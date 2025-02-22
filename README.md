🛠️ Alternative Python 3.10 Installation (Bypassing the Compromised .pkg Installer)

Since the .pkg installer is hacked, we need to avoid executing it and manually extract a clean Python installation.

🔥 Step 1: Download a Clean Python 3.10 Binary (Direct Tarball)

Instead of using .pkg, we download and extract a raw tarball:

curl -o python-3.10.13-macos11.tar.xz https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tar.xz

If curl fails, try using:

wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tar.xz -O python-3.10.13.tar.xz

🔥 Step 2: Extract Python
	1.	Extract the tarball:

tar -xvf python-3.10.13-macos11.tar.xz -C /tmp
cd /tmp/Python-3.10.13


	2.	Manually install the extracted binaries:

mkdir -p /usr/local/bin /usr/local/lib
cp -R /tmp/Python-3.10.13/* /usr/local/

🔥 Step 3: Manually Set Python as Default
	1.	Verify Python works:

/usr/local/bin/python3.10 --version


	2.	Make it the default python3:

ln -sf /usr/local/bin/python3.10 /usr/local/bin/python3


	3.	Confirm it works:

python3 --version

🔥 Step 4: Secure Python from Malware Rewrites

Since malware modified the .pkg, it may try to overwrite Python again.
To lock Python files from modification, run:

chflags schg /usr/local/bin/python3.10
chflags schg /usr/local/bin/python3

This prevents attackers from modifying the binaries.

🔥 Step 5: Verify Python Integrity

To confirm that your Python installation is not compromised, run:

shasum -a 256 /usr/local/bin/python3.10

Compare this hash with the official Python SHA256 hash from Python.org.

🚀 Final Steps
	•	✅ Python is now installed manually—no .pkg needed.
	•	✅ Locked against malware rewrites.
	•	✅ Ready to use in normal macOS and Recovery Mode.

Now, you can reboot into Recovery Mode, mount /usr/local/, and execute your Python scripts. Let me know if anything fails! 🚀