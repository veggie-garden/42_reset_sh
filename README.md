# Reset.sh
Shell script files that download programs and change settings after logout or resetting your 42 Mac.   
로그아웃 또는 초기화 이후에 필요한 프로그램을 다운하고 재설정해 주는 쉘스크립트 파일입니다.   

> **__Pull requests, and error reports are all welcomed.__** 

# Features
## after_reset.sh
- [42header plugin](https://github.com/42Paris/42header)
    - After installation, the `utils/.vimrc` file will be copied into your home directory. Then your user and mail variable will be set by the declaration in `~/.vimrc`.
    - 플러그인 설치가 완료되면 `utils/.vimrc` 파일이 홈 디렉토리에 복사됩니다. 그리고 거기에 설정된 user와 mail에 따라 헤더가 출력됩니다.
- [42toolbox](https://github.com/alexandregv/42toolbox)
- ssh key
    - This command checks the existence of the SSH key (create it when it does not exist) and copies the public key into your clipboard. Your GitHub and 42 intra SSH key setting page will be opened automatically after that.
    - SSH key가 있는지 없는지 확인한 후에 public key를 클립보드에 복사합니다. SSH key를 등록하는 GitHub 페이지와 42 인트라 페이지가 자동을 뜹니다.
- [42brew](https://github.com/Homebrew/brew)
    - Install brew if you need it. If you don't, you cannot change your dock setting by this shell script.
    - brew를 설치할 건지 물어봅니다. brew를 설치하지 않으면 dock 설정을 변경할 수 없습니다.
- `tree` (brew install tree)
    - `tree` is a recursive directory listing command that produces a depth-indented listing of files. If you want to use it, you need to install brew.
    - `tree`는 파일 구조를 아래의 사진과 같이 출력해서 보여주는 명령어입니다. tree를 사용하려면 brew가 필요합니다.
- `dockutil` (brew install dockutil)
    - After installation, your dock will be changed. If you want more or fewer applications to be in your dock, please add or remove the path in `after_reset.sh`. `dockutil` will be deleted after setting.
    - 설치 이후 dock이 설정된대로 변경됩니다. 만약 더 많은 혹은 적은 어플리케이션이 dock에 있길 원한다면 `# Change the path if you want more/fewer applications to be in your dock` 부분을 찾아서 설정을 변경하세요. 모든 설정이 설정된 후 dockutil은 자동으로 삭제됩니다.

## after_logout.sh
COMING SOON
