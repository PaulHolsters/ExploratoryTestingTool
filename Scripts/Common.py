import subprocess

def run_as_admin():
    command = "C:\\Program Files\\Windows Media Player\\wmplayer.exe"
    result = subprocess.run(["runas", "/user:paul.holsters@hotmail.com", command], capture_output=True, text=True)
    return result.stdout

if __name__ == "__main__":
    print(run_as_admin())
